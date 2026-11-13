Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA299606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZKRzNe/D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C3610E56D;
	Fri, 13 Nov 2026 19:15:07 +0000 (UTC)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 874FA10E6C5
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 19:15:00 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-67c02c106e6so1304331d50.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 11:15:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794597299; cv=none;
 d=google.com; s=arc-20260327;
 b=X8t6hkp32iPCX+A9yDHnwDvZ/3Dzwda2QkjeLo/xTG0td7/b30U38ZPX6I98EgKDMc
 qJNUdcNpYacdCXvvzgsQEboU80MJwhMDlgwrdDbfYxaJC6+N7NL6dtHTCsCWwW8g9l6Y
 BSuRvNxBOK7qZMVTK+b56Jm0gconBUfDZYkNYf3dxMpHCMOz30IboR6jIgtm2MZCOnl4
 WyYczkEqGzIiWFFbo3XMntUPQjoxv63uVIpkElxsGeEBlnJRZ3R9nwwAFUFCqhFfRgUe
 PmxeAX/EXL/Rr66Jh6LQRfeon6w016LTva/LN0qZ6RA0R3+MnW6zP4Mza5hX6yVCMNxS
 qt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V4Lkji1HX8R+QyAlAik1p8btRedCNisoSjayriZIZjc=;
 fh=Es1gobiw0QnOhIDQsP1RWC2bBGIYlc7EtW0OjWK3WTM=;
 b=jbM+jVvRjfmoa+oZdOIgSnmPiKZHdwfDg51OemcUB+aJYfqz1CCNuUr+7xHB3836Bz
 6lMRu+aVjHZfBSfe/GsRSH9Nl53r3LzNI6+IoQwKrszQMdPVAUkLB2V6fGE0EMq++MPx
 Xkar2mLhEvUDi+YfZWKyrJTWV9GmgLXwZlAhDZ/BGthROJpg7cR6YMqMiiXQhXNTvNsY
 sUV+kkEW09dmt+nxGRzoHVWWgRrefkpThZCn/XO8LgDrKhSqYftZSuNTZqJZXo0pqOi8
 b3V8qmtRlQH7P9ZqVjOy1b+LVkEuu69q+WCsJXAzIkusKI5hcwpwY1EeKQUerfmXssNO
 isdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794597299; x=1795202099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V4Lkji1HX8R+QyAlAik1p8btRedCNisoSjayriZIZjc=;
 b=ZKRzNe/DqD1SRAO7GCcpLaSoFuRRgR9cc7D4uxDVUrT2sFBRHoaKJlUk7C/qjLx907
 bAUaNiDY/Z5cNdE7adcNHaAUXD4P7z3+J8OPckK+TMDMYc/xsOUJR+9OzEN5vmBlEDIG
 vBnY/ZaZeaAN+sa1Et1+lW1RYuw+k5HhaPPIF5zTLhZJ2YTfJ41owMt49DKsKx5QKQq0
 +tc5NpNm5DIZYPzBsk8OhIgDYV5y8LcWNm5AFpumIn6ors230LTmGT7TUJeN4RTG0+vR
 0FO8xoqgdh2FDlPWQWX/gSDy2a8alQ14NVSSkoVU/QVddEVEt3vt+LD8SZmo/kDaDsn6
 cKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794597299; x=1795202099;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V4Lkji1HX8R+QyAlAik1p8btRedCNisoSjayriZIZjc=;
 b=XGPh0v3RkWipMMnx8OxIYqnXPz7v5o+10hPNKQq6ixckShelrWlDH9odjs/LNX5CrJ
 6HdEKn5Nqf8957+bznTuObgH7sRpHlCyvd3ce4Q6QcPozNdX9FdKPKErJ/TkA24Zz9ny
 dNAPzXWJEWx1b8t7vXJ7Mnb6CsxKDKZxje+590mLgccmn1m6fWckXY16AATQxwUc/Muc
 GjRgFe8jOkcNjAdHy3CEjclx+cGA8LXAKnL6bK4koQ4phHt9uYWmfQpCN1+S4yvvszRh
 ZUXJbPTfZEdePBEoNoNMFO7HFjiVV/y/LN3s9dMQftnpXc9SXMCY7SACsJtVrf+wm01P
 rLgQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH0/Ay3HSLePNV/BYTmeDQQwtpZsSZXBTqvrkKx18+TXJ+FcNUiy/4vJDVl/xG7Oa/JBg5siJM3e4s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9YAimdAqWfrVrLu+EwschmGV3uXrEeXSA6EFYGhINS9IPv8T17
 +Xdaba2q433jiGCxf4aGrGGstPyL76xeXYOecX5QkDZucs9p4mTFeONSK5BA/AMLO1OCii2sRpL
 cc7+xdDOIeJkcqoJ+ugaa8XNHsKpBnJ4=
X-Gm-Gg: AYBFou3B2FCxKjYqkr4rFWOINib39OroqSogiVxU/aHv8rouLX6OFjDzDPMLOq/M39e
 GMI4QCbJatLyraDSPq2Az2f5LGAdFY7a14+6A9LgKzZaBL3Tn2uSqWFDk/zJkM5EtEzzdxe9tX6
 nvIptwxxHOICoIXoltAjhkPAVf2HMealxhmVQK/n/ntmagbjX/Fa5ZuT5K0cGXcQlOlTjAdyKtG
 X2E5vTBtcZw+MaZpgydeA2F7abveyKd4fc8tYCYN7+Lk7ZOqgEARiMC2iqd3E/sjzka/DChtTZN
 dEwsauTsLWxsp5nA/q8ztt6NlBH3Rtd7HzSThhqTI3WBhgxVV3m4lf23BEC7Dwnh87qKqFFKjBm
 tK0OyvoPyh3agJnVXYFHz4XQH+l2tEaA988v+XA==
X-Received: by 2002:a05:690e:1188:b0:67d:98b7:8861 with SMTP id
 956f58d0204a3-67d98b79810mr345876d50.48.1794597299405; Fri, 13 Nov 2026
 11:14:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015-orangepi-gpu-v1-0-03566a615660@gmail.com>
 <20261015-orangepi-gpu-v1-1-03566a615660@gmail.com>
 <20261111004732-GKB2005@kernel.org>
In-Reply-To: <20261111004732-GKB2005@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 13 Nov 2026 20:13:00 +0100
X-Gm-Features: AclHuK_kboH0z5fWoPol696e94WfTnxywiDJDP5pOyMB6ipnYxJpzrLU0NPVDpw
Message-ID: <CABdCQ=MPPuTQ-3aCds7F6C1AZ2c79HVJXGjtqN9_jHpKo+0E2w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] riscv: dts: spacemit: k1: add PowerVR GPU device
 node
To: Yixun Lan <dlan@kernel.org>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yixun,

El mi=C3=A9, 11 nov 2026 a las 1:47, Yixun Lan (<dlan@kernel.org>) escribi=
=C3=B3:
>
> Hi Iker,
>
> You could drop "RFC" prefix next time..
>
> This patch generally looks good, while note that it has to
> wait for power domain to be kicked in

That makes perfect sense, I already noted it in the cover letter and
I'm fine waiting until that one is merged.

>
> On 20:56 Thu 15 Oct     , Iker Pedrosa wrote:
> [...]
> > Disabled by default; boards enable it individually.
> >
> As GPU is integrated within SoC, I'd rather see it enabled by default,
> so will not only one specific board befenit from this patch,
> besides, I see no reason why people should disable it by default?

This is one of the reasons I sent it with the RFC tag since I didn't
know how to proceed. I'll make sure to enable it by default in the
next version.
