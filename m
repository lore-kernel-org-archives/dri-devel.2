Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B61FD5F79
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD84110E0D7;
	Wed,  8 Apr 2026 10:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="v0dGvejY";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D05D10E0D7
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 10:33:28 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6385eBuw2995154; Wed, 8 Apr 2026 11:33:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=Y
 RbIUfy7PDUjzpSHaVbdZAuNWadSqt0BWYZ64+s6FzA=; b=v0dGvejY1qOLi4OWX
 cSd8OYKCKN5epd3EIE+jSol+If6RExyox0ntJaT9DgWfxFpfbmvKfk73L/bQDNKf
 sA48anNK2CaLzgXR4Z8XUDeALOEw08iIXfNMBL/oYWQyu+dkbQYRh2MSAth1z27d
 IESyxiozXQeKIombfglswcVgXVCnwmg7YviHcMUw2//n0S+qwLaWreQ1Y55xpOdO
 ceUMNds3TrKZN3Q3dB7Km9G8gR0OIBeNpn8l/4xyf7QvIK69hH97jiApPibjuhAI
 oMlV0FcUPmFVA9rzRIsLnnAQXcRL9ef9FSf3xAYR3b+Y4i0v3kkYY9HPINzOHrjU
 H2jpQ==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4dd4s2gs5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 11:33:03 +0100 (BST)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 8 Apr
 2026 11:33:02 +0100
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.4.178) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 11:33:02 +0100
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alessio Belle <alessio.belle@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <stable@vger.kernel.org>
In-Reply-To: <20260330-job-submission-fixes-cleanup-v1-0-7de8c09cef8c@imgtec.com>
References: <20260330-job-submission-fixes-cleanup-v1-0-7de8c09cef8c@imgtec.com>
Subject: Re: [PATCH 0/8] drm/imagination: Job submission fixes and cleanup
Message-ID: <177564438213.82099.271553295476946768.b4-ty@b4>
Date: Wed, 8 Apr 2026 11:33:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
X-Originating-IP: [172.25.4.178]
X-Proofpoint-GUID: _TMcyOQ8vC78jZMMA64wGo11iNMJ4oFu
X-Authority-Analysis: v=2.4 cv=cL/QdFeN c=1 sm=1 tr=0 ts=69d62edf cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=vO48zYV2LvQA:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=TDz46OUBVoeO_pJfSP8A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: _TMcyOQ8vC78jZMMA64wGo11iNMJ4oFu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA5NyBTYWx0ZWRfX/eQQBFVBZg2E
 Ol7j9k4HU3URWdMzOVwSOImzIkGBeYxlGqzExnLAasSyRg/51K4G5pLUuiuri0pu1HpawO4x1KI
 G+P+zkm9OAwZwpYAGtSi78AT9wmrPRrMjLQQRE9lMi3wYAUcJToHanw0t8vduYtwfso9mvHULNu
 m5HjA9ISZkKQKT2hKV9reG8Fl2jRI64qTa2EUWqEDqTZDIBLUj4edSfev+lEzljuBTe0MwXLi2z
 gmYxh1NhVdu1n0GqodK176OBD8IFLEGsczmNJPDngu2ZhFwrk3oQvrkfWk6optu263lnp3KVQt6
 aMAjI5ktnBDJdDHXSyxg1FZAV/NpgrRhcr8WWNSOXXi9TdVPqsSJvmUkuYEfXQdZLbqbGDvxB2I
 W7zpm1oxzvLI1oJ40oh3NoQ/IPFyZ0lo9DMxPoc7Nik6NIMUVbdoqPyfuK5nz+C0CeC/Ik9f3Hp
 MpRDyJ38fg6uOCpHtxA==
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


On Mon, 30 Mar 2026 08:56:35 +0100, Alessio Belle wrote:
> The first two commits fix rare bugs and should be backported to stable
> branches.
> 
> The rest is an attempt to cleanup and document the code to make it
> a bit easier to understand.
> 
> 
> [...]

Applied, thanks!

[1/8] drm/imagination: Count paired job fence as dependency in prepare_job()
      commit: 9cd74f935306cd857f46686975c43383e1d95f94
[2/8] drm/imagination: Fit paired fragment job in the correct CCCB
      commit: 4baf9e70cb756d78dd56419f8baee2978a72d0c3
[3/8] drm/imagination: Skip check on paired job fence during job submission
      commit: 18998b3cb7595850b8b2da55adb3fdc7aef8bc22
[4/8] drm/imagination: Rename pvr_queue_fence_is_ufo_backed() to reflect usage
      commit: c162e655092de8de2e0f7776d72919dd5e3b84f2
[5/8] drm/imagination: Rename fence returned by pvr_queue_job_arm()
      commit: 5dae1a21f1e7128a19c68212422383f700699d01
[6/8] drm/imagination: Move repeated job fence check to its own function
      commit: 402562e60c6c1b15ee359ba7ffed907baa886a99
[7/8] drm/imagination: Update check to skip prepare_job() for fragment jobs
      commit: 5c81eb2970133ad073214eb1e5b0c34a1ae793eb
[8/8] drm/imagination: Minor improvements to job submission code documentation
      commit: 62a36c2da774800bef893bc4bf8922fb9c07c1d0

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>

