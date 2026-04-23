Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ED4F99378
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8097810F0BC;
	Thu, 23 Apr 2026 11:50:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XTOGwWNp";
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1698010F0BC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 11:49:59 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-479d4df9035so2449516b6e.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 04:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776944998; cv=none;
 d=google.com; s=arc-20240605;
 b=CMbcEp1az9Sl8AQf202Xur/rVIxs3ckE0Bn6pc6T00uIPUBYjoj7tK1pDjtvB7TD4N
 rOQBBGiRATKLgEmD1jAES0EfQV7tTdvgtjPMIKJBN1b2NrtuQQslUDupCixcfyT7jo9I
 bzYGhx4Ginsbn2hQNKpRzRSAFX/AU+kR7OvNw2rD/QK1vkWdSsozgYCkzVWR9z8GCEvL
 +PsggvbcwcVfOXIahYc218TcEV3DqBWDx3YUCnoLfHzaV4NduNu0ipdMUOiTkkxJwHRz
 fXveUc7M9qtWzvxaCJY5spElHy3HHJxhBYtM9E3W4JC7nnI6EE/vXTeick66wqqdENoF
 UNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NMysmFkGdL7lDHKDD0+dBK5B2PGw1As91n2z5R0Wi3U=;
 fh=x51geuu1w+fYz4grb4OAdRKhmBFWyLk3ANvpXW4daf0=;
 b=ilvG3SGMHYEvVcQBBqGuLpr0//w/gAF3e1Jg8qK1XMUC5hJDIuDIXj+vp1i9UERFQl
 dzwnlzK2pKPSawkQc7jXoEQiD+OuyUnjQtJDPehr92u9nYwCGn9/nl8B0qkHUdrDyy0/
 Zny2oEdDo7Ge1vyGog0kV1CwCiCzvG3jww4/1S2i5yj9uaLIC4K0pm8l6+Gtf5wyudxA
 rtFWJG3scvCo9M0UZPWcro4HPIdvUdzdRsj63nwZnJ9dE/Wb/WyHwckhQyLyqJK7Lt0/
 MogtwhiV4IZvYdOJrnSAHt/uaVPOUPht48Xhcsyj+wP/q3V2EtKre+QH7yWBMGDh+11V
 hNEg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776944998; x=1777549798; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NMysmFkGdL7lDHKDD0+dBK5B2PGw1As91n2z5R0Wi3U=;
 b=XTOGwWNpjzUxzRjsumHh98rpxRy7ds1va+MnnE8MqCs/RIyz7WvftrzD5gPAaqA+x7
 9t9auLGo82OrMFH1IqfBBkqdgEKE37633ucu2YQGmIZu4IM/owXU/9GKase8UTVjYjqk
 pwFrQbSf5eJ1hLUmryzW7TIY8SbTNPybykVrEAXOyfkNiRJHmPTaHpsm04py+1VR/gFs
 i2YbUJx92bV1De+0SJLeF4rMCkm+sHUr94F5JXYygZls2AvFJQdO2jJ6L6kp8kKGUhgg
 nw2AbTVELS+kAmeXiNgefGEDe50K1v3a403jvgfW2MjbFXrfJ9HPsThCJWMdt8pxniwM
 BtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776944998; x=1777549798;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NMysmFkGdL7lDHKDD0+dBK5B2PGw1As91n2z5R0Wi3U=;
 b=iLPVYOvjhmPQ+GxD3JNNTHKrcsugd8W2RraVdagFALbcPTLPNbiH1BleUpGZvl/8r+
 eAJXE1A5srPAogI9Y1+ohvqiLoJ+GODP7Gl+2SdOwuz1/4qOyfc6UsfGf3/pqgU8ocuA
 V/qp8psBmq4Q5mHtiXkT3tWXYGgzf+LYOfjRttjRErLt3ZLQPLMfBHXCcLCPrUdNRFjv
 Xon5wSGZneNIoadXAMJ2Rpr61qxkNYhupA0LQk6zYdgpsBDSJYBjZocOOPSCpUN2El/g
 wKFkMBafgdfASJEYPupkTlC84naGZln4iYyPX6pUxEdOD+SG949eaQhhBmqzLcA3jwnM
 LMCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JjQ3B/YJvq9S7eJtJ3rY/4CYNLkcLW7deuKRlSjdX1dpF20gozebMa3Z+M1mTkU+79Tv1MIQBdXM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVZjCpxAo9OVbb55zVwcw7HNdjcE19twpeamPJjDFS4+Q9/5BS
 4jMIgU+wBufroiwtlaGwA3INY7PiqghDvAjUycGwjDdvTeJbgWlVHFIZJTV3/T9tT9IHcAr1P21
 RtOTvj2nIvUBMiuPw31bTWIcWCOyZ+g0=
X-Gm-Gg: AeBDiev3/GlHlmvG+XvloHGq1wz/JTeVlFfxWT4jInYpMWrmjTWKEXlHt/WzBoPjhVt
 +O0k44r90NGLvoghXaTuVcbyVGPAgSw9R1F3ua9y9NKFfUv882gYkn6uwwFYsOxyBCKy72fGkFE
 AjUTiXyaWoxStSS2IUu8HEEd2ajtFV6v5ZVlsV8TZ/7VppcsU70LlP5gNq6E8wqOl48qdw4QWyj
 SOfdI04lPvLrjauxsut3IEDipo67fC0vDQHAu1a6+7uGbKhCC5CM0y7tBdZhfRip57hIRHFtdrU
 TRQKEA3UruZ86IFqHwKB
X-Received: by 2002:a05:6808:ecb:b0:47a:4fd:95f0 with SMTP id
 5614622812f47-47a04fd9f84mr2979376b6e.12.1776944998182; Thu, 23 Apr 2026
 04:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260331061657.79983-1-mikhail.v.gavrilov@gmail.com>
 <IA0PR11MB718531C51736C57114D6DC2CF850A@IA0PR11MB7185.namprd11.prod.outlook.com>
In-Reply-To: <IA0PR11MB718531C51736C57114D6DC2CF850A@IA0PR11MB7185.namprd11.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 23 Apr 2026 16:49:46 +0500
X-Gm-Features: AQROBzCsr1tF7ROC5cSogOzcFX4U95VM00zHhQ_fb0LBMmia49ui3DZvV8SxZFk
Message-ID: <CABXGCsM8T4e8kaaO_bauHnN0yE5cxwkkcN+eAJWE8hnJ8RdSRw@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf/udmabuf: skip redundant cpu sync to fix
 cacheline EEXIST warning
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>,
 "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, 
 "christian.koenig@amd.com" <christian.koenig@amd.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
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

On Wed, Apr 1, 2026 at 6:15=E2=80=AFAM Kasireddy, Vivek
<vivek.kasireddy@intel.com> wrote:
>
> Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Will push this one to drm-misc-next soon.
>
> Thanks,
> Vivek

Hi Vivek,

I see the patch landed in drm-misc-next (504e2b4ab97a, tagged
drm-misc-next-2026-04-20), which targets 7.2.

Since the patch has a Fixes: tag and Cc: stable, would it be
possible to also cherry-pick it into drm-misc-next-fixes so it
makes the 7.1 merge window that's closing soon?

The bug is reproducible on current mainline and affects users
with CONFIG_DMA_API_DEBUG_SG enabled.

--=20
Thanks,
Mikhail
