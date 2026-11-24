Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E65606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=okonski-org.20260707.gappssmtp.com header.i=@okonski-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lfcsPDRr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05AB410F9EA;
	Wed, 25 Nov 2026 08:41:22 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 593B110F62A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:07:07 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-3ae85add512so36958521fa.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=okonski-org.20260707.gappssmtp.com; s=20260707; t=1795529225; x=1796134025;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xd4RdrnuYBeyiNKGIItFmSNJEjiD9KZt74bomDMs038=;
 b=lfcsPDRrZJ08Yl8qiBwG5khtMtDhHwvl2ZpILB3HvxZJ0M7uW0qB5YhlVN1Urm/u4k
 UleHX16DhYtdfhgYyB0BpL3Cr9XqL59mXjyaMYeg1nf8zPwdZvKFKslU124w6DSQQKmW
 hPGyO+aXlO5TRUXTxrEkI4xZrxb11mDttDCQpIuy34s83T+yn9W9vUyY/uAtx7A3D+nP
 jVPiHKiomg7utNCzjkKvf0hb3VCcneBer20qoawbIvycBQzGJSh5pX1nSBNBeqvc9FT6
 yN8L0xnbHejF1ls+zjxqhzZrfo/SxKYaZEptyYdfQBI/BSQq9suXoCcitnzpYe71X231
 tzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795529225; x=1796134025;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xd4RdrnuYBeyiNKGIItFmSNJEjiD9KZt74bomDMs038=;
 b=b3bRQInDsgODchwiHv0kxmwABAeBbF8nfr2yqByKxALgvY4usofqe59K50aJmZV8oV
 Xx7xtYqsqGpGYEZ5trH947Lq6etLXvmMxJbNgINIWYi7NWOSSwKZ3gA56HcRAwQHndqU
 6SNRrU0mBRkwR9xXecc7RIeNmYnPX5R1A5LQUqKiZ3N3hAcqRbyifYmMC9VGnI4sPjMv
 SfTY6UAv+UunzaapHICGt14CXkfwlowH+Ey4mm2NmNu32BPYExjdN2J/2A/vKJ8rXuEa
 3p8mDtfgR1lv4DPyGrRuD8guDeuQeVT/q48rJeOxeUsvuTXnjIDfmRhm5S8C+acY9Wou
 HjiA==
X-Gm-Message-State: APuU4Z+gtWPoaV0ZvlfzxLbfvuRQMJmIwEELnNaLyfEtT5bbrLsLdQ9a
 FKL/xJMYjIxqVollfbujUpGDwdRJmuf+HuN1zspaVTB30NHrGCGE4ow/oL70I5HipxQ=
X-Gm-Gg: AZFdTZcK/bUl7blRLWjwE0HQ65wwAlyIXt0nFC+AxG2za0m2XpBrfpAysEbKKuoe/07
 HSdXMRXZ75dZIUgo8lXEG7sc3gwfHau7d4aMeg1LZBlwQh62vu8BcTl67TIhVzU1mvpBjcPS3ts
 CNkicUwzZyct0iL/CyJkzuVyQ8amrESEhZnJtJWt0jXT3fXPff6o3w8fFS/Ry6eBkYWDNtYKOoS
 a8Bd3oP2yW+Nl9W30NIuE6nVc42DLYoj4bkgHyRtctoaTk7VvBveNisnRw/lT/vbQsHeXQnf7qs
 ObG1NBml0b2LwgANkeqyoXpz6/kglYxwk5Nx51ZwSqZ1xWBR9JxrYQlf6Pn/X6cs6DltG0glXet
 mIjQt9CHfW6k9TUwmqDlwu3Kmndus5CO9o80xPsOFuc2h038mzDEbKkuIz/ZYyyj1kru/Rc1UFl
 wbQJPMb/HtwM1tMKvt5xLAFw0CeRuDTbBYWQUr4j7kLlCeSXtPjOetaZPRghCJxMIIrQRjQXVKC
 jDhC5+qXaqBbKluzjPjbEVEWOojpI6m/bkKmNcH+Ig+npq/XwA85Rq0FuuWIR04aNK4JUTEYZ7I
 OzhLc3nUt6Qp0GoD/3TTf4BtwRTSBCG08vDM2QSX7nHn/ysMKHv92mQpBgvg/hS5VKg+r0LMmCb
 NbojMnYUDhzehUzqGZP4BBIvgttFpL3tQMBkP/HPkAZ4vygtLRyme3Q4IdBcrGTjCGGMamOALTQ
 ==
X-Received: by 2002:a05:6512:39d4:b0:5c1:57d7:d9f4 with SMTP id
 2adb3069b0e04-5c1bc7b4c5bmr4508188e87.16.1795529224958; 
 Tue, 24 Nov 2026 06:07:04 -0800 (PST)
Received: from ?IPV6:2a02:21a0:10:748:1::2? ([2a02:21a0:10:748:1::2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1bcf332c9sm3842243e87.7.2026.11.24.06.07.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 06:07:04 -0800 (PST)
Message-ID: <4daad602-10e4-4cd6-9cf9-7f47f77a7922@okonski.org>
Date: Tue, 24 Nov 2026 15:07:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amd/display: Skip flip_done wait for
 non-modeset TEST_ONLY checks
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 amd-gfx@lists.freedesktop.org
References: <20261123220913.937402-1-jakub@okonski.org>
 <20261123220913.937402-3-jakub@okonski.org>
 <47ee6326-08ca-4dcd-866b-3a543cb15665@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Jakub_Oko=C5=84ski?= <jakub@okonski.org>
In-Reply-To: <47ee6326-08ca-4dcd-866b-3a543cb15665@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 14:05, Michel Dänzer wrote:
> Does a commit with both DRM_MODE_ATOMIC_ALLOW_MODESET & DRM_MODE_ATOMIC_TEST_ONLY set really need to wait for pending flips to complete? Why?

I was not confident at all and tried to keep this change narrow. It's
possible this could be relaxed further but I have not tried it.
