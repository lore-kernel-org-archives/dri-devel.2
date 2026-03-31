Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC3C109B485
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA74910E979;
	Tue, 31 Mar 2026 14:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="UDQOpdOr";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B61610E979
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:56:57 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5a283c44478so6255373e87.3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 07:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774969015; cv=none;
 d=google.com; s=arc-20240605;
 b=N/Kk+Bwi42C4onqw2jJWGMYpig4SJOMmZcCY5CnsxphSCOe5LqC4YBB40UnP390cm/
 flEbCJY+q3nwQYM8oB6bNjM4dULJrYinsdrru5VWh3Rj36/bAH82evPACRNjw87XUhoe
 oHyeM9hPbOkGKTp+5//q9ovp+Z7RWwmoxXkvl9xpaOry8WNSDIrSLLEdDO/vFmyiCLzq
 J6aiGz2VsoP8Gh3Q+b9WuoB1dMk9gEi/7XmlMvm1R5BFgokmiS+vfFcmTFcmPCMpL3Gt
 QyFOLXajBJEyuZTU6MCHqMqIfDTZP2NzQC9W32OZjo1I49qTBSCbkGoHmCk9pZo0mA3j
 d0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ANeukgXaFkO22KK2P8lUGEhokznHH/pS+8BuIXKDR9E=;
 fh=CtL8UKoh2YhepDlnxa0GUUdJlJ3MMdYFo4DvKrLJ6yQ=;
 b=bO2zCgQq+pQbwfhicnXnKI85/ONKEUQd+eB/OZYqffc+dKxBHXOSRL35JMMdqchU8l
 OsvrCBC3ImRN1lvTxXUtjlMFkVlYHhP5N9Bjjn/W85ffrUtc31Ys+5ZfQ6hJA8L311it
 QNFUar2I0os0JlyFgIUfcoi4MqAWZu6djc2ijXnoUYtZ8pO1yuyX05OCgIeOaMYovdB3
 eolYknt8Uu/cgivZqZJyaXPXfr/rrdzw3CB9ATsAZpa5YhENPAGYa0o43fXaPwaDV39J
 py8CXZszBOZVcfrWFiGFAGkXSHIL77s+0pbKzutYcTaHS5drRNloB/U9m2V/Nb838TEH
 Q2kQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774969015; x=1775573815; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANeukgXaFkO22KK2P8lUGEhokznHH/pS+8BuIXKDR9E=;
 b=UDQOpdOrkvuRJUSmQHNjfPMG/vNpot+0B9D7ggeK3qokrhIXTl74fm0KkaPGaFXDOr
 zlJxUw0eSBG/P9EOEv5GYToMd8tKmQWjCG/m2tcAAKL5sHcZay7qK1y6SgaU1z9q1UD2
 T9rrX4TxXscA+uLUop6ne/khJRcS/FteToVBvhLPn5nXvwJL0JafQt0lBfyVgkIrxtIk
 H7bs8WEcnWjJ2OCmFC2o4kGH92Bicj4InzjFBMLToTOs0XKG2s1VAS0WldofQElu0NOr
 7YAEBVEGncy57G55/Xoep65hHa/DxjO3YGgo98OHlcR13CC5esU+cFqBNjwQuBipie8k
 lpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774969015; x=1775573815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ANeukgXaFkO22KK2P8lUGEhokznHH/pS+8BuIXKDR9E=;
 b=axySqRvN2oerQuDowx/MK1QkTsAbSMsF57NQ2823aCuMPsxOJ7HmAzp94URrlRYBYO
 1NoagBGSJuVarBQJo5stH9xe4q4/j7rlDg5UA2RKPrPDFPllSDFzbUgZMUYw7vsRPWkD
 du095hIkxNG36RI4UK7cNHq+szMpjR18qRTSYTaRuwelimU6uIVGX3O4PDfamiEsnHzG
 XHUy+6m013e9vxZHb2tp5uJx6CabwhPaat3K0Kej6b7fm+UhAdKRi0+E1zYqv8juMaj1
 CGv8vPyjy1S1DXdcGM2gxgnHySu5KDOnQendI/pZmfgM5gwBoiNvmAYrAQNtBgKebdYe
 2lWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe9iBoVXWWWo+nFgOBw35mgl0FH+drh7DEVoC0mF4gzax/1y9tihg9/c3FryOEui+bMLxdDz1dk0k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLvcDnD3iHOPsq/60bWkv88Kkjv4WuNImdj7G0owhZrRyUtEnt
 nUdbrjaVWJeBqEyHNp2PC9ov00X4U+L8hK61BA62fOqhqHqM8zzYjswD6CCWt9ZAQvdZpylPeYj
 Urk4zv1C1+y2jF4eZVN2nsq9Tz/NLw98w8X8dOfbHCQ==
X-Gm-Gg: ATEYQzw2/ltoPERt1ACcPH0/ocdJ6A3tvYc8b6uh0x6AfrCMRKMtP9/eY2WGoNHWLLD
 oIV3yXMQ66QvN2AEOwaGb8hEu1H+4D5o8cLrCy8EfXh1FwrXWfZ6c7Dn/jronyPYdFIdZgjvh2p
 RyrGEiDZ7zTfBLH1QSthXvJ+ixcnXs7HAQpGUmYF0acyJq3aSNz0kJNfX+OqesM+vSjbf79pfxN
 smUCmIaVIEziJnLptmE/UvHbMzKvcbEvArsMCZXDU3M/USKxkGHNpqioNSvKS1zUs73OS3pn1Wu
 48A2SMnawk7E2zk0OtS/uzFOi3obzDLuKLBzmysk
X-Received: by 2002:a05:6512:1088:b0:5a2:a13e:9095 with SMTP id
 2adb3069b0e04-5a2ab5ff25emr7387493e87.9.1774969015482; Tue, 31 Mar 2026
 07:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251224144708.61167-1-marco.crivellari@suse.com>
 <20251224144708.61167-2-marco.crivellari@suse.com>
 <CADnq5_NJFv=xEyN+VQOvt=7QifK2rFUcKru92YAeX+2m-9PSNw@mail.gmail.com>
In-Reply-To: <CADnq5_NJFv=xEyN+VQOvt=7QifK2rFUcKru92YAeX+2m-9PSNw@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 31 Mar 2026 16:56:43 +0200
X-Gm-Features: AQROBzBVA_D1iAW-Kp85UaH1G04gvnNXlDENnGgd1wdQCpwHDZgCRMm0f50Wzfg
Message-ID: <CAAofZF4cmrZFFiMnxFh+LEc5b4WF3VQ1z7GXaeqovK9UU_H1Cg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/amdgpu: replace use of system_unbound_wq with
 system_dfl_wq
To: Alex Deucher <alexdeucher@gmail.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philip Yang <yangp@amd.com>
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

On Tue, Mar 31, 2026 at 4:55=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Applied the series.  Thanks!
>
> Alex

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer
