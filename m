Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7303606A8AB
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 03:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KMAqNmmK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C21810E054;
	Wed, 18 Nov 2026 03:23:19 +0000 (UTC)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC1610E054
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 03:23:13 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-67da3d03263so400951d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:23:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794972192; cv=none;
 d=google.com; s=arc-20260327;
 b=pJPrEs9fpyl6qtPyhK7b45Z+2qWKVxgiRM7WaFTexbcxI0aIFGa8QloRCtEfHQTh7J
 gXEaqVRi/CCEYNv7qeTa+N3unyrKK7vx2yryiJVPBRG0YBbOK4Bzx4KBLrAg1c8/xaUN
 AICenVXYekwwo09fES7iZCF4JNRq4Bp9CrqJjNvKhkHHUSC2JfHipX5WOJWtPDnnXbtY
 vGcruTiAQc4o7O08zQnhv+1JYfpVbpRPlYngZqijOKLJGbj/fPB28wJp8+9id0m9ogS2
 GQeZtAhRtmsacpLAhgqmnfwi0PScCqunrORTV5wTPOkhlR7WRb5Qar5WK9cVqLIMDDv9
 z+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kgQVnIy2LaljVsYf/m21ANRk7tKYZaMS2Uj3NNM4z7A=;
 fh=DwZ9pdE3tKkW7+6SevmmYQQ7RtqbpC7Y3ob3boqZ9hw=;
 b=TRy7mm5wTagQthXVCAPHDR8ffUw6ZvnibLsisKvbl9wHDB0SM/zIj5M/PcJ9ZiiEm+
 GM8ix2hl3gOladp06t5AafYbmK3VlX95dX9+A2HzpGDyGigo/71CWq1oSU9/wwZOoaYT
 /9AidjB8jj21iFRwRZK083SBTo0Mg4ou/WgDtLsgNPSBnL6KaB9kb3iNpkAuoDp+SImI
 ie3HAHND6CbzMPRXKWPm8hsMAEakEEBDzQikw1x/kRgt8A69lcHc0bd/UcUtZiiqRNKH
 ymHHYUku3nlpCbyTaEViovUl3tWDuEjPfmghBKYCWkoUqklRYKU67cr1/XK4VEyPsRVE
 REQQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794972192; x=1795576992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kgQVnIy2LaljVsYf/m21ANRk7tKYZaMS2Uj3NNM4z7A=;
 b=KMAqNmmKiO/B5ImXwCXPe1pPADZvOMjDIDAi81Nu/HoPqBsGOsRIhALVHO4LHEBU8T
 lJS5Q10tbsnQGsq+cCrExHi5e6yz1OwKlu9Zqz8E2pEot1rf5OvkvYfFkpQBDV9Fw1Da
 S/INo2utmR9FUCQZ8WSP6Prv7rwlTyWb69J5pt9d7QTzd1GxQ4HOqr9P6rnXybBMhhkn
 0tqKQWEBZpCod+UgE/0TY0YI9SjWCF90Fgp6QDhceXzywucX2vCkIp3mUZHoXKwMMvd2
 UlmAwkkcMQqlSrxzT1eDM1mK6pUEa3MqY22pCGsWVrdA2m4yG7DR1vNNIqCvVJRLGlOz
 WOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794972192; x=1795576992;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kgQVnIy2LaljVsYf/m21ANRk7tKYZaMS2Uj3NNM4z7A=;
 b=cnMMM3CJ9LAm1VsND3POW1W/C1iKsH8CD4hTsQhWTgNnTPRwLvLW8Fo3I/xClwyTrN
 6OEmL27WMIP17wWiPLtomfNwPCtWodBvZ7XKclj2j2N1YeGSDwUGmKVVnV1F/XtYZWud
 fvVpSpY+ps2UthsKCfOU1oQeCnYw+EKFfU0BhjQg/E5CINwzD9iuSdybl5kLSQj1mWiW
 sWVwkY60nPl0QhXE3llPYxQeLn0ARcpTpvR0AxhEGx51tIY9hzYA2TkKO+fHrVXg+gpn
 1Wg6dkWApgnAMwYwYlTo6i31U+AkCZhrJC70YEBUQctZv2MGh4oy8u9CSt0pnY9RK0HA
 hn9w==
X-Forwarded-Encrypted: i=1;
 AL+hErGVp15CzeLfLqCJ+dafoRtd/G94argZd+B2V3FxepEnhOBu2O1g5bZibyyaAuQIGzKD1bkQr7g5NqY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/fXhSOJ//20iSqG++f115oHXNPY74rQ76N8JzZUaa5cenjA1CD
 3kyDcN0g4noNceYltO6cDx1MR4bjJU4Q6fbKx00afzg6OI/pc7a9z58jXELcL8/VbbwzSJjbPcI
 a702NchkejE8/NK64WvPmyLFgMtbyJJU=
X-Gm-Gg: AZFdTZfIPOYrL5uAGg69G286C/YORJaf7swOpoIhvvcViDdcJcfhTQqayxNgU6lFj49
 nKt0hxzgewIrvBl4GKdZK5usnV6BAk6D3hS1UezBDOzVWYAEVOsDua6d5MkTEhL2s93wbR8nga3
 akjTaz2yWB3DGC/qj0uESMUokGHfaH8gtJ8HRcGvIZaHC0DEP1eOsv//uOWoZ3R3svs2bb/KNVD
 4YeHJCtBjplr8R84FKHPBWX1qTtojtOfvIzOBLb8UVR2uY2mE5OgIn4OfqrrXF5zg9+s4dUJtDn
 E70nDFjUv3UXga/U9ZshHLzUzpaR1noK/rJPs6rTtz7dxt+NBKNOrHnVzvS0WvQqy+OhBBI6m9s
 5rvLi14WGKmHVQ/DXby+fmtCDy1EIgN/16dH12w==
X-Received: by 2002:a05:690e:bca:b0:679:9afd:c0dd with SMTP id
 956f58d0204a3-67dd3fb2cc5mr535222d50.111.1794972191725; Tue, 17 Nov 2026
 19:23:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260510200047.6117-1-contact.kartikn@gmail.com>
 <c000f684-0989-4ac7-bd40-e6d224fe070b@baylibre.com>
In-Reply-To: <c000f684-0989-4ac7-bd40-e6d224fe070b@baylibre.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Wed, 18 Nov 2026 12:23:00 +0900
X-Gm-Features: AclHuK_ZkY0RDSYV2_RKJg7dT0_TwSkJZ-C78piu03I2zHeguqiI82HuVMbgf6c
Message-ID: <CAKbEznuLqhXx37ubw1a1aL8QXy-G-ULsME6i8=ZbrkO=2A=PGw@mail.gmail.com>
Subject: Re: [PATCH] accel/rocket: fix ignored return value in
 rocket_ioctl_submit
To: Daniel Drake <ddrake@baylibre.com>
Cc: Kartik Nair <contact.kartikn@gmail.com>, tomeu@tomeuvizoso.net,
 ogabbay@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi,

On Tue, Nov 17, 2026 at 11:27=E2=80=AFPM Daniel Drake <ddrake@baylibre.com>=
 wrote:
>
> Hi,
>
> On 10/05/2026 21:00, Kartik Nair wrote:
> > rocket_ioctl_submit() calls rocket_ioctl_submit_job() in a loop but
> > ignores its return value. If any job submission fails, the error is
> > silently dropped and the function returns 0 (success) to userspace,
> > leaving subsequent jobs potentially in an inconsistent state.
> >
> > Fix this by propagating the error and breaking out of the loop on
> > the first failure.
>
> There's definitely a bug in there, but this approach is just replacing
> one incorrect behaviour with another.
>
> After your change if there is an -EINTR generated from within the job
> submission, this will cause drmIoctl to retry the exact same job
> sequence, likely causing parts of the sequence to be repeated, possibly
> with negative consequences.
>
> And on other error paths that would be bubbled up by your change,
> userspace won't be able to know which parts of the sequence ran vs failed=
.
>
> I think we need a deeper change here. Is it possible to fully prepare
> and arm the whole job list first, without executing yet, returning an
> error code if anything goes wrong in the process?

I agree with Daniel.
How about splitting rocket_ioctl_submit_job() into a prepare step
(everything that can fail) and an arm + push step,
and first preparing all jobs to check for errors?

--=20
Thanks,
Gyeyoung
