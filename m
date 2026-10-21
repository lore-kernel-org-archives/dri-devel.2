Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E234606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=Dv10+qBk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7792110FD46;
	Wed, 21 Oct 2026 10:08:08 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 245B710E232;
 Wed, 21 Oct 2026 10:07:57 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LA6BDs2673753; Wed, 21 Oct 2026 11:07:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=i
 5uNBN+MRyPLdo9zowEj4PF3R/r1IegXfv1EcVCX6JI=; b=Dv10+qBkmVlqj9Gfa
 DbbXkGnO8noEVjzkzmQ+VTdS9ImdIxrZymlyMsbPaSiN4lQest8xGTR+5u7mhqdT
 2c+uOKbttFOpj5r2aHjVWnkHSwO5oigDCzvdXAPZuSadcOnVTx0/9DA7deWTCD3r
 m/e7RbFh4kHGOJin8UtCWeDjTggyjgeZ7AMZSvzfJul5X+qXKsrBna0ClhF5AGYm
 RbktW74f7Lpch2XU2NbOh+V7fXMsmYsbQbdVhMznnp4j/FGxuFgrL9LpZX3csYHF
 jbLr7to3DqW8C7jFNO1ARC4KRwuRiA8hJVFaO0bLqo1pO/rZYqpOszzCs5Q1461F
 S1jAQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hdvkahcfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 11:07:50 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.158) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 21 Oct
 2026 11:07:47 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20261006-b4-check-virtual-addr-space-size-once-v1-1-677687e661d1@imgtec.com>
References: <20261006-b4-check-virtual-addr-space-size-once-v1-1-677687e661d1@imgtec.com>
Subject: Re: [PATCH] drm/imagination: Check virtual address space size only
 once
Message-ID: <179257726720.217387.2226239851508710521.b4-ty@imgtec.com>
Date: Wed, 21 Oct 2026 15:37:47 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: Ns-ol1rxYiO7LbTLppQnEtUZZho5AaM1
X-Proofpoint-ORIG-GUID: Ns-ol1rxYiO7LbTLppQnEtUZZho5AaM1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MCBTYWx0ZWRfX+S7EoxalJ4vZ
 iO2WAd8mS/2NQvp1EdNtkSIeDWC62iaxBcpM7dS39GIXLoRDLllzA8tKB0gzjt0rriAK98JaKWo
 qtJ7crx++WiLUSC4WG7YRzc21RI0cXjPJrZ8QwnOsvOw6+MTvh3wcsSBIEC2OGh13105XjGqgfP
 bt5ZYL4i7Cbj4R9W3v+KemXqt9k5gI4Fhi0IQev2UFN8c01Q1GjS2QjjLgjRMX1Aofr/m5oESwX
 dVUiLVx0L3MFjGcEloeC8jKLmf+LVHtr2DF+GazQbeZYfG1SzjLJ7fD6gmNTQn+gX8iVcl+b20x
 UNo7R+hXNrFvuan5hCRnHJBLsJ/HEJYMcv6f2OTqigQ8NjEQcX+VpqN/ZIbvva2y3Ryjo4se8LX
 tLHKS/z3JvGCGR5oukhMrDDyfVdGsLYav57LTYtycN1tHpritzryf7GEuNH7PGK/Q3pVxWyv8jO
 FygRgcfD9WGa/XSIjRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MCBTYWx0ZWRfX8jlBpKi5gYWQ
 /0/Vp3kbu2hdcPhil/ehX6wVOsHokGHw9wAMi1N9wwyk+vkEyCT3TyIj2y/4AvQ+YT944FzqsXi
 XGVkY0mMRFQhoeINWSmGKcegCBGvoLY=
X-Authority-Analysis: v=2.4 cv=eO+GH3p1 c=1 sm=1 tr=0 ts=6ad88ef6 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=x1VBDH5lXswA:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=V6QY0zI6KbwSomB2j5UA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

On Tue, 06 Oct 2026 11:08:06 +0300, Alexandru Dadu wrote:
> Every time a virtual memory context is created, the driver reads the
> size of the virtual address space, as reported by the firmware binary,
> and compares it against a define for the same, but both values are fixed
> on a given core, and on top of that, all known Imagination GPU cores use
> the same 40-bit virtual address space.
> 
> Move the check above to a new function for GPU device info validation
> code, so it's performed only once.
> This also allows other areas of the driver to reference the relevant
> defines without having to perform other checks at runtime, as long as
> all cores keep using the same virtual address space.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm/imagination: Check virtual address space size only once
      commit: b3de601e57d983e4a42e27d499516041c11c2bde

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>


