Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01299C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58FFF10F329;
	Fri, 24 Jul 2026 08:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="hy3DnTFl";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB5E210F328
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:02:32 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O7avfi021025; Fri, 24 Jul 2026 09:02:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=J
 9X34VjSxlk1h3QSODJQpOllEpeK4zcV8bjlDOa3VDg=; b=hy3DnTFlR0yUyTfeu
 WT1fdOl67Omm5/Ix6bHJbOdm/MQOzGeIsidAvo9P0noCPzzokqAKjmiWPXVgK0QS
 kOtX0KdAJXOy8UOgavPiyKf3LWNhtEdUc/bAdFFfyabgh4E7vjLZcP+OQ2lbXlZW
 ZkBjxKhZVW2lXPmG3byR73yvHGI0ncuvVCS7XISPhK01kwhX/lg7Y3gr5/8p7pu8
 JW40Fn+PQk4Pb1G/CsLbCIlPyogd40g2Xz1rpMI1POzg8p6P/BArpVDaygJ2YwEv
 Fh9gj0OsQ45lHQsL5pnwL0eFCalQdmnZN/7v08PWiu6tlZGNCYpbege+LVqGH11h
 IWq4A==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fhq52bgvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 09:02:24 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.9) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 24 Jul
 2026 09:02:23 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alessio Belle <alessio.belle@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20260720-fix-pvr-job-trace-hwrt-v1-1-b24551802efb@imgtec.com>
References: <20260720-fix-pvr-job-trace-hwrt-v1-1-b24551802efb@imgtec.com>
Subject: Re: [PATCH] drm/imagination: Fix value of HWRT address in
 pvr_job_create tracepoint
Message-ID: <178488014381.43731.11195246438931887622.b4-ty@imgtec.com>
Date: Fri, 24 Jul 2026 09:02:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.4.9]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3MiBTYWx0ZWRfX+e+y4lCGuDtX
 d/zg7jMfsfbjmAObXVC1Qr2UVPpVBgaLhNcYDykaoSlOVK65vhim2PYUYA5Lp5j3LpmuTHBgvE2
 ZMI2c6WBO6lENddCC+mHeBWWk6EVYbaSSd4NCtIYQDNENU91IxWPKjdEyC0vvD3AT+RHO6wWfnp
 CYgNQWToCFMvjBAlpWJaAwsKGh9VFgaSUriYAdGrd98cOT+73HO9xnFmf1vrM1iIForgfSzv/1S
 eCeSG8cSf6LAEIiYldD3WiHjr/dq986HYoXPq8AxeYrfqY9hNYtgxds8m8xCQYG233vaDdFKeaW
 dN1cDXdmFF32frZpxIjYv2erF8aXtnLwwmvZV0HoPuqi4+OGUspoUxy3PUtToM2BIalbDF6Xm8S
 +qm/ho8vUX44MCBZMzT6FZweT5KA/FkDCEsqNpyvZ9hVgiE+symr9/ZxJ/6wKocdyg0JKPEGxBk
 m4V+5nzyWRv2G4GWeKg==
X-Authority-Analysis: v=2.4 cv=B5+JFutM c=1 sm=1 tr=0 ts=6a631c10 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=rvaOABGgyOwA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=6rTy5hXIHTOJUlV47kYA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: TPJ6O5y-XZZ6mFpGAhTyEINNAsjh3pRs
X-Proofpoint-ORIG-GUID: TPJ6O5y-XZZ6mFpGAhTyEINNAsjh3pRs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3MiBTYWx0ZWRfX0rXMJRtqSymr
 NhXOmyzxEeIl+ITIMW+s0ypv2RrgGn8r33y4F4X5tDFt15OVESjNIqAz6LVo+hLxTtWib1mt7o5
 FGWEi4gbhJktfkwRORwLiQfoKlv287Q=
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

On Mon, 20 Jul 2026 16:07:28 +0100, Alessio Belle wrote:
> The pvr_job_create tracepoint was using pvr_fw_object::fw_addr_offset
> to display the firmware address of the render target structure attached
> to a job, but that's an offset into the firmware heap, not the expected
> full address, which is more useful in general e.g. for cross referencing
> against firmware logs.
> 
> Use pvr_fw_object_get_fw_addr() to get the full firmware address.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/1] drm/imagination: Fix value of HWRT address in pvr_job_create tracepoint
      commit: 112badb7245059c176e3924f9cd9ce2933cb0082

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

