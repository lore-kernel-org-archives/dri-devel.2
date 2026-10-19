Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBC606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gnoKROwM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A1B410F2FF;
	Tue, 20 Oct 2026 07:36:33 +0000 (UTC)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71BB510E538
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:06:30 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-6798eb0d13fso1326843d50.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792407989; cv=none;
 d=google.com; s=arc-20260327;
 b=LQ+5puvHf9W7CNJdhN6YzxYQA2vAokXweWU5VS5qaKgsUXRa+/xeqkN/sN4VdJyqT6
 W8wJM6G3teHKokGui9TdYz1NFWBeo4pWkTdOzg8d67EbJV++iFK7emff8xCPF5pcGYrZ
 MFemHe8O8bhaefSmuE58E482Wm5r4x0oMf7g2ePXOWMtuSm8It01VmsT0nmJBr/tdFYS
 LFiJvAuvRKaKPUUCbaDncIJXUtzElhY2vrCglkTtsXsilQaFAiuPMhAZfVCdVhbdFwWk
 rS5Ns7jR/nkNYLdR2CzLMDLYlaFuUSkUuV9bwwKfOaoJEIHwbvQfN2hHIS0/ozUz4Wiw
 0VoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ast1zHJ9Uz2YssWCBu1jREzUx8HTb4eQoYAKdnW9yDE=;
 fh=DsTX1xV/+ZsKqezelzv0+dqszWAQOV9d/qMyhOhdUBQ=;
 b=WF83VHJy9OpkyUH57v2z6EItjwCs8qjs0WRAaVLjT6X8XvOsuMOuH9ybzjsmj/kCfZ
 NAyd3iAzAHvJlAtYPAE3xKH4DfepyZfAzkB6rAyC1fauErcLZA7lOcPcX/x4f/cULFMx
 g5RzFY7M4w0RlBuMfT/8rMFKa6VvBAkd2L9eus0uAP+cq5brfGYcMZkZXHU63EJC2lvp
 fnDxk3VX3c6tieC3re0uGNqij0hY50iPH0wo+HxcWU6FnHidJYJfLVv4t86KBjR5vIKc
 BVh6yB1jd14EBX5ZxHWN90JEuF9GQxonHgjDVVORVbq8aArZ22ieI3vpoHTF7VfLcSmG
 8hvw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792407989; x=1793012789; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ast1zHJ9Uz2YssWCBu1jREzUx8HTb4eQoYAKdnW9yDE=;
 b=gnoKROwMe+OiGRLkQCmVVNMGVJICGVIthf/XNvu37D7t4kMP/QiEtx/b4x2fjv3qxg
 VES85/SlquqG6nnoRAKL+oZ5qpg+ryfKJIUdv+4OOc3h8Ma7RKj7VMsJADIKZDVZNlMd
 3MwABoHQvt19bXuvcirTDioKeY2jZ38luW9ZH3/tHYNdnw0C3AzqK+TnIh5REf5hMJNj
 XIy3XGqAALBBxk0F8fbOQcL7XfG2XJGBR0XB+4AtPljTZx6YfXKIH3Cx8mtGShoYtl7A
 ssptObFcPZqIEjXIPbBiNzWaDIbuk9vrHi9QBJR3ZbNa8IHFmEqQbwVB7wIqEdp4Nwnc
 2rXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407989; x=1793012789;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ast1zHJ9Uz2YssWCBu1jREzUx8HTb4eQoYAKdnW9yDE=;
 b=eWn24Urqx3OfqjPbPXqOK4Ip03gKmul7S9TZUeR4HSkrGMCDud1zuuxjU9WxpyFd1Z
 rqt9RN7EUXMkBALlvoY1gEhpomrE5Sxic4mDs7uHg8w9JuaRRDOnLW8lkgB0ankl0tVX
 Y9ddpxdx5dv0FCpT+hbCCU0Wo6MsyoA5xzyhfXFTfhAlEMOgGdRFiGUd49ZUo8Q6jI7A
 g6O2StSQqYfRoS2B+mu/CXSvVJ2dQKKVJvfA+iA6rYMTJYhH9vE/mcDFbVtS3Jpy3Pvp
 s1zroN3UbOQt0mZqE7wZVRPpzesdTONN7pRGtrkCeimoMlL5u9UVXM4JBcMqYQKQuYzd
 36Ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2s0Q4wAc8k/KyiM9q4Ocm7lmIUkIgafEB40wMqKJ8cIwOTqCWB7v135Dc3gu0L1mmxpc+Bu1ekFQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLp3/3LF7o4l0Br5fuML0MSQBHSI5pQhGY5MDC7CL6o2NJOwlfa
 TBV5Gbc/GVqjJMzSrbeYf2kxeYY1mkTH0kaHxfbBhr0wAIMG2gmn5/AJWBlgkP+rAnHIWNBot6B
 xSUC1PAMhjI4MmHwlT5SmurvshxW3VOY=
X-Gm-Gg: AYBFou0JZYY+EYsjSSqHVDCTaYXTLfOTXqCrSA90p5DP+caTAJNe+vJ/ugftyFsXCr0
 Mqtl6A5w7EBdE6WXDULlf/gh711A05mCkVNRiX7k4/TuOWirw0uur6XT4mWVh07nTuAyyihzAt2
 5hc7z4yqbyqDmWkZeVSJW6EILdhml/6W8+6XA+4HuvOYBa3PpGqDl/wYr2m/XZbV4QzKKgHjqrd
 sdh38kzyZm2uk6KU31A5sKnsN+Ut/rwArUKUo48bJ+nys/4HWMXwNuZGmpslFC8lt7fC5fr27Ve
 rz/d4OzrowofXwNuwslAsP7sHVlzq+Hjpy4azXOPenxsWx7WJ0AD5gNNkZ3OR1/47HfGjUmoAfz
 bLYFaMiyrmiByj1bVPzgZHsacIsr6FQutV6DBom7KGjEffLoIOh7ZI3tZbZBW/zArWQqZCSr7Fi
 w3ghOybQ==
X-Received: by 2002:a05:690e:4004:b0:676:e85e:5ec with SMTP id
 956f58d0204a3-679ca93e9c2mr2047972d50.139.1792407988921; Mon, 19 Oct 2026
 04:06:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016162912.64581-1-lukapanio@gmail.com>
 <20261016162912.64581-3-lukapanio@gmail.com>
 <atX2Sf4GJNFYq2ZY@aspen.lan>
In-Reply-To: <atX2Sf4GJNFYq2ZY@aspen.lan>
From: Luka Panio <lukapanio@gmail.com>
Date: Mon, 19 Oct 2026 13:06:17 +0200
X-Gm-Features: AclHuK9BPbEV3xXNig3O4K-KotL1JMndrdN2hrEB4vNyiT7qjydGuoSSOSI_klY
Message-ID: <CACi=Ov4qxW_HmgcjRJLg3SWGKd2S+3rcevjpp8ELf6z7RBP3qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] backlight: Add Awinic AW99703 backlight driver
To: Daniel Thompson <daniel@riscstar.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, pavel@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, deller@gmx.de, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel,

On Mon, Oct 19, 2026 at 12:51=E2=80=AFPM Daniel Thompson <daniel@riscstar.c=
om> wrote:
>
> On Fri, Oct 16, 2026 at 06:29:12PM +0200, Luka Panio wrote:
> > Add a driver for the Awinic AW99703 3-string WLED backlight controller.
> >
> > Register values follow the AW99703 datasheet (V1.6), the structure
> > follows the aw99706 driver.
>
> Given how much the structure follows the aw99706 driver I'd expect there
> to be more code sharing between the drivers.
>
> Cold AW99703 support be implemented by extending the existing aw99706
> driver?
Thanks for the review. The register maps differ completely (chip ID,
brightness split, enable bit, current range, boost options), but the
driver flow is the same, so I'll turn aw99706 into a per-chip-data
driver and add AW99703 support to it in v2.
>
>
> Daniel.

Thanks,
Luka
