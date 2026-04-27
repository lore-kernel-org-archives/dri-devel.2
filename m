Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B92BFF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C020C10E749;
	Mon, 27 Apr 2026 13:29:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="eRNTSJY+";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E0110E749
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:29:09 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RCDs6L3285157; Mon, 27 Apr 2026 14:28:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=4
 kAzaO8B91XtCPYE+tKofwppIabMGQ0lBPRYkdJBBiY=; b=eRNTSJY+L5/XGPWGZ
 jofSL5Oxko3znDNo9r9ICOnz7eCGaT8INaU+Z3mjY7+S0dq/H/L0nzNl93INC75a
 j0ov4t9jhmAtYbSBYYKCBcM2lNUEMN+7MXTJJzNfMyovtdEOFe4xT1nvclnnIcWu
 rGUPIMLTns78R9Le0ApQZKTSes0N7AucM4tQFsl1nxg33QOv1ZLwyHC840F7A/+A
 89K8gaQIE+/qrBb9QdA6N0FxVgeOfUEXDAW4doqQ+7RaHQ3g5uk9UCCqel05YqXp
 uRkeRQnpb6IsExga9voDsccLsN5rEG6Pe58EqskACXzHUe86tVrsHKq4tk/5l40W
 meiNQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4drnpxhrta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 14:28:57 +0100 (BST)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 27 Apr
 2026 14:28:57 +0100
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.6.104) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 14:28:56 +0100
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20260427-ftrace_fix-v3-0-e081530759a8@imgtec.com>
References: <20260427-ftrace_fix-v3-0-e081530759a8@imgtec.com>
Subject: Re: (subset) [PATCH v3 0/2] drm/imagination: FW trace bug fix and
 configuration update
Message-ID: <177729653669.38075.5805575811651128778.b4-ty@b4>
Date: Mon, 27 Apr 2026 14:28:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Originating-IP: [172.25.6.104]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0MyBTYWx0ZWRfX7EGPI62xbWx5
 HZD0rc0pjEV7m/5IbpL0bQeH1yM0vlJ3fwkgDh48EBSfvGCH2M5P2CDgAuXuBK1j2V1Zium31pm
 X9t7j8aE/tX+IPs4ryKyNkdZv1LwUUy3WmhRiATZRTY2fKCd63OhiROYXleAwIA1y0dOAvtvyPJ
 awQzUBemh+6NqRlghEhP7i3KWF/yIpfNp71ex8E6mFmMQrc9ZQpWJf8lpRJZpMDZkDuPAAjmw3U
 47kORiCFwOs7Kt08M0dpXRwwYPMKSZH7SXMWNhjvS9cMPDENfRWBxqu/E8auGPTbdc6tfizztPb
 qDzituJre+GU7NdLq1LqO4nUzyGPpP6LAnyaGagfXgToo0fwj3d1kXcX1g6vZ8FXWJnU9HaxtDN
 WUMe9MGIOVhq0xEF2ie1ah4glMo110y8AutxjTOeG7OtUW8Y6ThbDP06IOSGpvZZRo6MfdL9MkH
 QqUp0rFVwVuVS89kpAQ==
X-Authority-Analysis: v=2.4 cv=G9gs1dk5 c=1 sm=1 tr=0 ts=69ef6499 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=P4yVMNkQY8AA:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=3i9OpufdHZUMjzHleY0A:9 a=QEXdDO2ut3YA:10 a=2zFLWz2JKXgA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: fGrWkvS5ZM97fKSpIqcj8fDM6FE0Wb54
X-Proofpoint-ORIG-GUID: fGrWkvS5ZM97fKSpIqcj8fDM6FE0Wb54
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


On Mon, 27 Apr 2026 11:01:36 +0530, Brajesh Gupta wrote:
> 


Applied, thanks!

[2/2] drm/imagination: Restrict init_fw_trace_mask module param to read only
      commit: 96f865ed44b0d4f7ecadee3855861ef38f25a3cf

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>

