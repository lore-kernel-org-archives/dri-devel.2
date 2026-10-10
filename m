Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACE5CA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 08:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B1410E9E5;
	Sat, 10 Oct 2026 08:13:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NaTWk0Sr";
	dkim-atps=neutral
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BCA610E9E5
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 08:13:55 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-3a49a022221so3853781fa.3
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 01:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791620033; cv=none;
 d=google.com; s=arc-20260327;
 b=bK7JsIbEo460K4StIfZVzPU1rokjQfjknMkmc+PSt2P93DrTh5kYK+Og7TafxtArEo
 6x0v5MlMkPZC06UNJ4VrvXNLXuFcWIZpNImtqFVjyv/FDPa0PRY+pOrf5O2GvEjOtaOQ
 Z7vPEhl2FDg29+EbIsE2VeIU01jfluoSMhZWcuQzLTDVTlyB6Q4FkamRJysi+SHTZ8cE
 zk86TazIFd7WNcBx20ogQSTZtY0a5dFuq1nY+9BH3KydSbhSr8ph680Su9OPUwOutbTq
 Qy8YjcxrW7o2OIE5G7rw7XGxq6d+rRE/VnFB6CF8UOy/zJ+Sv2+pnX9y4PVqgcdWbrOL
 CCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v95mXYZS8OV/hddK/8aCeP00yH/oKndJ4AKBv1pvm/U=;
 fh=4PSQk6cTcsl0L8wIYhVVujPlxnwx1uE3aWf+FDrCZcM=;
 b=WyyhWmVkPa6j73+KyGOxo75drpgH7IAuNkf6lgaVJ+IBUOUJ869DYdrjJtESUJxv+j
 IZThdPf5lU5FmvQ8oXoLW7G8hx/m8+6ZrpTmCRxLSKDZAD1LNSLgxw46ylWgH1e7Mawu
 ktOzHZ0ZmBBHOX5nmgohg21vlnJwyaEARoG3MaKnUf2tRzvcXQwVoyXBa8Ly/ri/eirx
 0bLRhnuD1OUZdt6Xo9k4zjdJzYwtZgbRusiEd265zauhYaVG3liCJNmnQkUXc4KHhIxE
 LJIyCae/QMTTxk+WpWXFNPXYpbhkx9ZSICWhh91OFS04fnUFSe9824dpUkooKDSW+Dp1
 KyMw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791620033; x=1792224833; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v95mXYZS8OV/hddK/8aCeP00yH/oKndJ4AKBv1pvm/U=;
 b=NaTWk0SrZHP1vqavyJOR3QKOJqno/DthUseluqi2/pH3x3h5bAkcJxBX49zbh2ye3y
 kqKfLMAvvlwgu8xDIZe/6lPNQlXPM3lc9r93A4zqfVKY0JRW/Diy/AHJz8bGnJiV6jXg
 6r1QU6x3bqG4eDNWyb5cNxu9AMXd6Fbzmions+kNxM11giFJg7B9GMFvrUwModaegvRw
 2etZvyuDWvthlQet6a8xYHLrnQTCfvzCbzAoMEUCJFaXO+Drb937GfsL2hHVS9gak3hE
 BNpFTKQWZBxgrUkVasPnwJ6QlRhd6jTAOyfxXwIwLjvBMCOcsvgz1heEfwJAZN1QSC/J
 RRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791620033; x=1792224833;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v95mXYZS8OV/hddK/8aCeP00yH/oKndJ4AKBv1pvm/U=;
 b=neDHYdM97UoHLALozJdYyR9/Wp3PMbMoiS28k4brJR0U3zapwZMPUQ/W/4YAIisaPS
 mVVeb72okssU8z114T9QXAQpTuzt7ia01boM3K1rMv2NqFLocM6PBQMMGmtc5TcTTwtG
 X/SuMnyRJgO+i0kqRduwXKyIuu7GnlWUyTPPZShHuGB38GkBYiuIGcnanvxkGi+KYDFn
 OFT5SG13tlB9OsTfrF7Jb4MwhKTSmvVL44MEFQEbsBLJTXBUU+9mLCpiKZjqBu6Yfc+9
 mkXpGVlC+cRE4clA/N5EUTxRfOJTv1e8koObbOfi+3ENAw7LmhIribSc5UACEZza3rdm
 gEwA==
X-Forwarded-Encrypted: i=1;
 AKwUvByGw/JCJG6jnqB7zSmDuC3mtep1OFfZ/6Rz2pF8VY2eQrk9wGFF708urU7cUEzIUUj/uTFs1S5slsU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL0ZqzQb5aWLoqQz5mtDtxT6YqdET0EUWT10HzlSNFfrdmWaPag
 1ValullsTw9qvtTdGNd5Ls0MENWqR4q+Lo+LJFgrDrdVs9vRkDlDvdu26tq5qJ7gpWY+fZUgIBx
 IZYHfQxQKDq+gF96HEQkKF/PT6erJb/k=
X-Gm-Gg: AYBFou3azoo4UNRASomCgKqbxsRNUoFesDYJwVheTPSYMjReE6u5t5BnI7qlhdIsJBv
 jEBDhaoztna3PP5vFma4IMxkhYtc6zb42BpGDjK0QFwbp8FXR5+IqK14JoA5gOlllXS33q79RVc
 eFbCq/whV4YVcLsMFzFAjsZDPlNka/cQPhx1JPRi6TzIIGx+C0LazFsvssRCQ5HdImseMUf3yqL
 pT6kQ7nsFkau6DX2nVtDwU2gXe+zeqvRFeD74ZvxQAXJOr9PpWAdB59haXTuXedR4RMhwqH4uUg
 RDpridUsB5xHiPwgyXjz/NHFZ+YzFcTGCa9r6WqgQqMrIOWRGvngxe6uAmvy/FFY2NfT039+wX+
 3IKFzSkmLpXAfA+giZ2BMgCyHstiaVQoq8dh/yoBimMqWtlpQqGSZ6Rif6BJWxO5uYMPEYjtOFG
 g2oIf68pvew6nEJQoLS4TpCwi3vNc1uNujukyVVRI=
X-Received: by 2002:a05:651c:2221:b0:3a4:9e40:d7fb with SMTP id
 38308e7fff4ca-3a9c53985d2mr10277901fa.7.1791620033148; Sat, 10 Oct 2026
 01:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261009154526.43528-1-cenzhang@linux.microsoft.com>
In-Reply-To: <20261009154526.43528-1-cenzhang@linux.microsoft.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 10 Oct 2026 11:13:15 +0300
X-Gm-Features: AclHuK87hlToSKlaS86YJtsi34MGww0jdhpR8cjy__Mr0Dxl209enwY_IZs85Ms
Message-ID: <CAHp75Vebzu0XHN0h_ehpmNfipzcR_7xS+Lavyd2beHUmR7t_7w@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: update outdated struct fbtft_ops comment
To: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
Cc: Andy Shevchenko <andy@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
 Hungyu Lin <dennylin0707@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, Oct 9, 2026 at 6:45=E2=80=AFPM Cen Zhang (Microsoft)
<cenzhang@linux.microsoft.com> wrote:
>
> Correct struct fbtft_ops outdated kernel-doc comment: 1) update
> field write_reg to write_register; 2) remove non-existing field
> free_gpios.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
