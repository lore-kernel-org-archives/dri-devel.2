Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD28C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 20:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5544D10F4F2;
	Thu, 13 Aug 2026 20:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NCKl7I/L";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82BD710F4F2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 20:06:38 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38dd1cc8dc8so27697a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786651598; cv=none;
 d=google.com; s=arc-20260327;
 b=LOa5PIBcCJYVqVTaFcQTRW5lMxAkE/yr8VRlt1Am8F2CfqW+FVqgrQ5H+IsfpY6zIg
 PJapVtjpKUOpqiH9qwQt4AcXrx9SgD2fGg5VZ3NUlHUZaVXXoT3qlLB9PCbkomzdLnY0
 RPYPue4QybF1u9N/bWd7IIx5RGPo6uFoDrQIxi3assFev9v1pl5QjPqKzeKize9Z3AbH
 C2DeMS+3MVayskwqF9gY8LyPwkLq0+N0Ayt/CwhFjRwObylyKZgidIydJCUpIlUMmCRB
 odglb8GJF6alm/3RLXJzOr9nPxzCmIWxclrA5HFz+akhh26024U5G2u7mI1i5qNanpgk
 qXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NrDY9sHqJ/BvNZ9jxPue3aREvcMXvBmJ3pnl6jN9+AE=;
 fh=uWbJrWr/Wog8vI+Txrh6JWy/PvKKc6ym9chuvkOe+Ds=;
 b=KmE1JR2jRIy6KaHQwkGYa2Zj0jH4T3WGM3+fbd7DMfvpDne7KoQ3A59clsU4z+i2Eh
 Y0uIm7uQdkr/ST0t0k8xxEhJZetKdnPwl6+3jvngbO6o40AHhh6sO+hPQWAUaZdmnJ+9
 sTjwUtUIHcEzI1JtZ9xragajk9kozu+8p+uDtfoupGVIVBdRPAQGGlyx0mBPcOqIuI6d
 s8/nURTi3PgKuCIOYnXwRAlbTEmasaR0/ap+bTw/2BuPqnaViF2R9T+FCJPS1yy5TO0o
 +TEbr2A8JiWKw6xyUbJTeMh/mV50b8qPMhMzFVf1QahEtM7cOp1AyQI7tIoQy49cialJ
 8xIQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786651598; x=1787256398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NrDY9sHqJ/BvNZ9jxPue3aREvcMXvBmJ3pnl6jN9+AE=;
 b=NCKl7I/LshXi2K/iamdNQKIqHvQLOC7X7HWEP5KhPD4msWq8Q6mFqTsOBH6U2POH9B
 +fv3ssMqrVHN8UYwCZViOzemZy31+BetK+7W9PjPs7mpSLvzds94KYulrDhBHZLVxpFE
 NmiI6yuRxqJFRYcRjVeCceKy7u/BVP0OQ8fq9wc4ZrZNuEl3yxNn1toL+iJNSZG1prPc
 zW1eOQgxvepnq5qPRsQ5Hx6McSYAE0BiioPBUybIAW/Xpp7eo2rQmUpHZ3zM+Pbonmq2
 C4fYRbDzm/UT6g4cdo3F0dW1+kZKZevEc6SST6v1Y/jMiU3lQaqUi4XIbKNhTFjAVfXc
 9qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786651598; x=1787256398;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NrDY9sHqJ/BvNZ9jxPue3aREvcMXvBmJ3pnl6jN9+AE=;
 b=JnwGLHrcr6bL2MNAOCwxSRUORvAZEL7WS61DOqCtO2BdeXkA0S3i7K/i9w3sLb54UX
 j1qQqvEroATO3ZbS3wKjypa3ac8+yMkOESU0oWxCxYMjKR0KjgC81AS2PZ7h9uIX9T4z
 J6hbtigEkgISJ/9HThZq/U/8OddrVa80pLHeNjvt8zTQSYoQNiX9VpHSf5MG1PF0XPoS
 FirALD+lU2C6/0n8DFDmpYff5DpSztWdmKzjrZ4qLGNteRABg+OnQEO/o0FZlxoRzKx8
 /ockD8kdRQSZy1Mfs3Rt4mFFodRFcrviZyWFgxQrgLib3z0osVLOTeoPUnhPTnz70/Jf
 YULw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/eEawlSY3HpZj8o4e9CW3aA/4m9nnSjDqVJJJtpJ7lrgfb5QTArW5HA14/NRNtXk0d4E5qQ6Wfs4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyT6ahJ/qrV66lnvDytdk/uTiwJHdVOmMvhxU6wcq5/+WMslG+h
 ykBjwfOkwmjLklZk/a9le43qPVCx/lOY5RwOwI6N7VGtSgsRDDO0qwZNVEK0n0lc6XRQZoD8pqP
 JqEXI9l12OhMNpFR5g6nsLemypsJAxa0=
X-Gm-Gg: AR+sD108TrR2Lwk+JK6bg7qkj0nUuM68I9snxPFehSLRAldrwuKFV2ZXuptZABO2Jok
 T9UooGH3iX5Oqho5oRwlEOx2qHr6MKo4brb0/b3zJAEvmeWWSoTzvRDtT953wFunR4TOobHtaPt
 H1P6pkJoUoQh2okbwTySGy9kxfWMMwwy7/3UglvJt5I9qTNdChqGgdv5YkSqYBiX3AnTFHYB9K+
 +sCZo0VfYZmNdwQcc/LuxWIDYzLjzQFMwkOATP7/MtV7Cipt3N9XzHQRr79TtPQu09+YoeKDH1+
 IhrBYwXLpo8g2a96IfMtelXJP7dsU82xDVvR70nGHFWZVJ04nFRfs2KRSfLi/g8vmaduH+2TfT+
 pPQbQvmUOp9sc3I0BGX1hw5t5wHGIqmE=
X-Received: by 2002:a17:90b:3142:b0:390:af7c:fe5e with SMTP id
 98e67ed59e1d1-3933e5e1b69mr272474a91.2.1786651597929; Thu, 13 Aug 2026
 13:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
 <a505f9e5-b416-43e9-934d-c5c29b8a70e9@amd.com>
 <9420bbe5-46a3-84be-eae8-596bc42bddac@amd.com>
 <CADnq5_OR5bFoFJoMoj9bc2_f47TunVnDFrmA_2tT+0k-DZk_jw@mail.gmail.com>
 <20260813195059.149991-1-taimuraz@kaitmazov.com>
In-Reply-To: <20260813195059.149991-1-taimuraz@kaitmazov.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 16:06:26 -0400
X-Gm-Features: AUfX_mwH-or38BS_oUcXJwyrUvpLFXovJkb8CFPGz9kcSXiCqclCgO7-cgMQ9XM
Message-ID: <CADnq5_PZxoBKqsg6i0eN-wkOBF3UrEZ2cVkMAtgzVD7Kv6ZSDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] accel/amdxdna: honour the SYNC_BO range
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Min Ma <mamin506@gmail.com>, Oded Gabbay <ogabbay@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Max Zhen <max.zhen@amd.com>, 
 Sonal Santan <sonal.santan@amd.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
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

On Thu, Aug 13, 2026 at 3:51=E2=80=AFPM Taimuraz Kaitmazov
<taimuraz@kaitmazov.com> wrote:
>
> (Resending to the list -- my earlier copy went to Alex alone.)
>
> On 8/13/26 21:54, Alex Deucher wrote:
> > PCIe transactions from the device should snoop the CPU's cache.
>
> That is what I assumed too, but it is not what I measure on npu4. Leaving=
 a new input dirty in the CPU and running, the array computes on the previo=
us contents, each out of 20 runs. Flushing that same input and running agai=
n, it sees it - so the data does reach the buffer, and something is not pic=
king up the dirty line.
>
> What I cannot square is that ubuf maps with dma_map_sgtable() and nothing=
 else, and on x86 the DMA API no-ops the syncs, so that path looks correct =
only because SYNC_BO clflushes on top of it.
>
> Is the array expected to snoop on this part? Happy to run whatever would =
settle it, or to be told what I am measuring wrong.

The snoop should be part of the DMA from the device.  By default PCI
devices are supposed to snoop CPU caches, and there is the option of
doing non-snooped transactions if the platform supports it.  It
certainly sounds like these are non-snooped from what you've said.  I
wonder if there is some device config option to enable snooped vs.
non-snooped DMAs?  If not, then either you'd need to allocate
non-cached memory or you'll need to flush the caches appropriately.

Alex
