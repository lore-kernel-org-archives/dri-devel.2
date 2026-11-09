Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F10E606A333
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=jfmQuB8W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD7D410E12A;
	Mon,  9 Nov 2026 15:56:31 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8297810E12A;
 Mon,  9 Nov 2026 15:56:25 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6A97AFPY2070716; Mon, 9 Nov 2026 15:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=u
 b4W/RbE0pCbIxx5Kt+BWv/BjrLzOeNWH24Ty0SbfZA=; b=jfmQuB8Wk+dhQjm4/
 aY1qhgJsGI1Delz4BJTPk/BEYmWBfkatvzvbDs1J+eExcMN9Engcm7db+pTLSRgv
 tVt/NRxJAfZJz6kgdapslnFtTWSNk9UBVdqOJqegWA5KpGnqp8ZxoOIoPMawA0BL
 YhYAWiWP8veFGfPrQf+BE2j7fJDe2VM8OaGLD4/tLsxbrrTgPfMD/4ymNSKFWVqX
 4X99GXcRUcmlVX/EwAijUHgNKVXjvL/HFxhB8K+8kImp8LZn6+x3AuHBMRHvfO78
 lydOSg04G8h9WR0mfgIBIzBotQxLMEY/4RpBD+Y3hFUrSi/3UZTID1xi/ttXRoh9
 IBZ2g==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hu8pn8aym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Mon, 09 Nov 2026 15:56:17 +0000 (GMT)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.8.171) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 15:56:16 +0000
From: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Gyeyoung Baek <gye976@gmail.com>
In-Reply-To: <20261109-b4-include-mmu-defines-only-in-mmu-code-v4-0-20a857dcbbbb@imgtec.com>
References: <20261109-b4-include-mmu-defines-only-in-mmu-code-v4-0-20a857dcbbbb@imgtec.com>
Subject: Re: [PATCH v4 0/2] drm/imagination: MMU defines updates and
 improvements
Message-ID: <179423977642.219837.12947609406304968231.b4-ty@b4>
Date: Mon, 9 Nov 2026 15:56:16 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Authority-Analysis: v=2.4 cv=P46vFSAu c=1 sm=1 tr=0 ts=6af1ed21 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Rd4DrVCMV_EA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=4uCMMe0gVBjtOtVTJnUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2MyBTYWx0ZWRfX00iA3aW7q4Fx
 /JDrTAWEUcEB3I/Mq0IDnFirUiCdSTWcKs5ESh+Hb09ZpzV7Qb2ZlKQdORh26PALjqCJ1XVE5d2
 +Hl5KkPvsXxRXAT6Mf8PieteN0j4iWAgvfNizG3F+RponKHxIRbd8U+1Kl9RkC6/ZAR+dk6Wywj
 yBzug8SzGCbZyB8GvNvCrSTZZUd2NT0w0yS9Cm9IMlCV+a2XWwJqYMftY2tB6hMIVMiiOx09L93
 tqA3L5+FJxY2wOPDY0bTLjJ8OHxWzwxq2OqO1wX0QMyZ6bYN1AouUmKaRhoymSTvjfGpheKd8mY
 decW3/MybY8THxm7Xus15KiCcHLo7Fg3a+FVdHqmYhRA/ZWNjmNxMexTOZKlFtzwl9B/CAdQoBg
 EdphAetrEHCtH/soPymwk72ONGk1Yas9YyaSGZzho9w7X2PzEh2q8v8qOGWlEdK0chUAsqD9Biz
 Ms4HSpm91h2cSu1Fsog==
X-Proofpoint-ORIG-GUID: w-lMVLw5PonFPlce3xV7GMkGzf9EO55G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2MyBTYWx0ZWRfXx8iHJ7LzPE3f
 CgnQaJJ8g15Xk4ueKQMnqE9T5iTAJGEbDIAP7BPH629LeDHBPsTd0B9VG9jsv0RYYyppxB6Ftc9
 VeVvyJQ9ZkiDxW5105oirNggLvWNPcg=
X-Proofpoint-GUID: w-lMVLw5PonFPlce3xV7GMkGzf9EO55G
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 09 Nov 2026 13:44:50 +0200, Alexandru Dadu wrote:
> - Restrict the inclusion of MMU defines to MMU code.
> - Refactor MMU defines to use kernel style and access.

Applied to drm-misc-next, thanks!

[1/2] drm/imagination: Switch to kernel-style MMU defines and access
      commit: 588831ba403aabe7774a07eb92c1e9451dddd354
[2/2] drm/imagination: Don't include MMU defines outside of MMU code
      commit: 8deaade4a5a4ff635df91e246e42139ab2b33f6d

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

