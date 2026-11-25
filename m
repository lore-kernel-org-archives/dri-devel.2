Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4C606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=okonski-org.20260707.gappssmtp.com header.i=@okonski-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LBT9sySw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD7EC1120F3;
	Thu, 26 Nov 2026 08:09:08 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6CFE10E317
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 21:57:14 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c5118deebcfso948612866b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=okonski-org.20260707.gappssmtp.com; s=20260707; t=1795643833; x=1796248633;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EscVSvEEWXaJWdMSZsEK6jUAQTPG/3riC+SyPLRH0Y4=;
 b=LBT9sySwW41fres4uyzikYD1sXIKQfA3AdaFDfoMOVkhdp+GlcGgRh9m2FFGE4TKpr
 v3iAMvUqf5a0dF2AKv+pO/Asu/yH49QHIA+rQP3tG3qzJy7VgvsvRBhSiozm5CjLQBN0
 US7iYy0KdLsFcKPElfUfYEui1NlHVLCSGqPmhsEAL2pgsY771BXOHCZdkMGMxTsYYOVY
 nKvyS8Mk9xn2pm9pydZ3vDvaC11MbWgFlms1pRfwwdxvcln2f9iCX7C7IHMQK3yiNsIW
 JbLKVah9Oo7nexXRSq2Npxjd4t1uzF1Cm8314tZ1ZFXfErLpPEZ9r/SY3mkbmatsqRTv
 Vdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795643833; x=1796248633;
 h=in-reply-to:references:to:from:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EscVSvEEWXaJWdMSZsEK6jUAQTPG/3riC+SyPLRH0Y4=;
 b=F6uecELfD+yAlYogOgSucaRXOKbUSqmNLEdMroZ+rXnr5ww5lCZdajkWEE0f0qI1Jo
 VNC5VMUcqk3LUKoVCmcYA8OOWPheY+BjOWSfubGr9krLMt5tSD7cJR3hTYEL9W2RiSMB
 c0NzoqCwje4WjbEVJgFVht+Z4yBMF5wxD3Pc0O5Cs1YA8R8peQtP0YeGTQmSeog6hfLv
 w5Wr+Jj7zxq4qbMfRchteRF0gmsWBmCrUBQcZuHLJ5HA4+Dv9A0esYaLfdn4e00nhNPW
 Cwd+hA7+80WuECp9CxbxvQq2fPCfg7d5z5YwmPQtkpvZ/s2ob0TOk/TiBbnpqFF9iBvo
 fhVg==
X-Gm-Message-State: APuU4Z/HISTQ2HsAdmnG1ftnrZYD3Qi9LhWhEekGE6lX5vgQsjCcnFQ3
 qKbh2yVmv7EE9e0p9btaaq8xUFOtg18Y+jJ02m7fIADPKZ0D9GHc9q+81kz0HA1VFNQ=
X-Gm-Gg: AZFdTZe61wrtpVx21/Eco6SyN8xe/daAoB6itmw1XoqzedpFpWuXJUvVVkDPfygSxqK
 UFzfH29ZHTKm4W4i5w9Qc0nKe5T62iQQvLjiNmX0RidKrCNGRK9fUjDEpELEtu/mZKNA9ayYyEQ
 T/DvGW93IhsVpl7zqOLs/jAdzK2Pxi6GDZJ0+qx0HlWySd/u6L9uRQa1flNLJ4oxkHSYK25etkj
 EozyJ7AxQe7oYFzN1emW4gG3XyfehsDzYQHTymU9Eii4FZXWVCsICkZ5JJjNKbylFaOFrNfp+2/
 YyTQiKH+4W2gZ7D+2AArrYWjd9qcaJSdF3wXtLALxQWqgkf0+nepI1+C3i0dOmhdi8kJAMlifLc
 AUKVlRbsIKa8Qv2TX1z03V+QtrYQhT6l89ZFOrHM6gxrGncnM83FiaH4HyrHtqrrgG08qaiJ6os
 PDyvZxrj5SK5dES32DvMProCrd+SnibwKysPUXxElLn9Vop8RneXfPHwh7mJEjyKyWWmz5bBp99
 yWhBZlftAj63zaRXg09ZQGtM+t5hGNy2Uq8YPhAKrnJSdMX4LMlIWDn4uJBRzsc3zTbFrwLSX1a
 SibnC55azv7kxnoDQ/831WPkfoN8sOFTg5Gm/uCIuwNmqWLNNUMkTU9FCdkbMjH1kvChMvz8VRE
 uKzPyY1w990hK5CLplZg3NMr6obFInNqaZaf8OLdHPzA5cD4n
X-Received: by 2002:a17:907:c07:b0:c50:c04d:cbb3 with SMTP id
 a640c23a62f3a-c516adc890cmr999837066b.0.1795643832968; 
 Wed, 25 Nov 2026 13:57:12 -0800 (PST)
Received: from localhost ([2a02:21a0:10:748:2::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513acfeda1sm731381166b.6.2026.11.25.13.57.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 13:57:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 22:57:10 +0100
Message-Id: <DN4MM3ZE5TZY.2P79WE24F8DZX@okonski.org>
Subject: Re: [RFC PATCH 2/2] drm/amd/display: Skip flip_done wait for
 non-modeset TEST_ONLY checks
Cc: <dri-devel@lists.freedesktop.org>, <sunpeng.li@amd.com>,
 <siqueira@igalia.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <amd-gfx@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
From: =?utf-8?q?Jakub_Oko=C5=84ski?= <jakub@okonski.org>
To: "Harry Wentland" <harry.wentland@amd.com>,
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
X-Mailer: aerc 0.22.0
References: <20261123220913.937402-1-jakub@okonski.org>
 <20261123220913.937402-3-jakub@okonski.org>
 <47ee6326-08ca-4dcd-866b-3a543cb15665@mailbox.org>
 <4daad602-10e4-4cd6-9cf9-7f47f77a7922@okonski.org>
 <a1dee5ea-2a50-47d3-9a81-eb1a94869815@amd.com>
In-Reply-To: <a1dee5ea-2a50-47d3-9a81-eb1a94869815@amd.com>
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 24, 2026 at 7:29 PM CET, Harry Wentland wrote:
>
>
> On 2026-11-24 09:07, Jakub Oko=C5=84ski wrote:
>> [You don't often get email from jakub@okonski.org. Learn why this is imp=
ortant at https://aka.ms/LearnAboutSenderIdentification ]
>>=20
>> On 11/24/26 14:05, Michel D=C3=A4nzer wrote:
>>> Does a commit with both DRM_MODE_ATOMIC_ALLOW_MODESET & DRM_MODE_ATOMIC=
_TEST_ONLY set really need to wait for pending flips to complete? Why?
>>=20
>> I was not confident at all and tried to keep this change narrow. It's
>> possible this could be relaxed further but I have not tried it.
>
> I have a branch that removes the need for that stall in atomic check and=
=20
> passed the work on to someone else for validation and review.
>
> The problem with the existing code is that IRQ handlers reference=20
> in-flight state, especially dc_stream_state. The solution is to decouple=
=20
> the state the IRQ handlers need from anything in flight. But its liable=
=20
> to break things, hence I'd rather be a bit more thorough with validation.
>
> I hope you'll see patches for it soon-ish.
>
> Harry

Great! Does that mean you'll be going further and superseding my patch
to cover the hw_done waits and potentially other sources of stalls too?
