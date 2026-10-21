Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4B2606A321
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=d+wZ1XqP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C6A10FD36;
	Wed, 21 Oct 2026 10:07:58 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7422810E232;
 Wed, 21 Oct 2026 10:07:52 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LA6Tge2674780; Wed, 21 Oct 2026 11:07:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=j
 Xm9xLCKcJdiijo1krCekhMqSFULWJOFFkyzDCZrNCU=; b=d+wZ1XqPcKObbQryY
 z/iuJx1UuQDZZu8Z0uplwSu3oFkFKB6AKtx8pKEhbgkXHoEpRGSPWp7V2ltcyShV
 oDTEpzBiI88IlPj44YU3tWSZRCbNE1BdB0wqkfqJjf8P0p0bG4SG4tBxRD2dfh6B
 xD/qZNbd5EFOvsUDe0CE9A80rKUNYZPuayMFUyejh9cZSNP/UGQrLrKfRmUqVSJZ
 GCm5gBMgnVud2h8HZ8wwTpSLLxv3PMAebMJLqY5zzAL8DyM+VDce5AdA9iBe8dGH
 Q4ZIgUkJrCW3FSIH2Orn1qpNdlnU+0leHAzYc7RJjg/g0Cw0Ejp5z3CJHivpPI0/
 g1hMw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hdvkahcfb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 11:07:43 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.158) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 21 Oct
 2026 11:07:40 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20261009-b4-improve-logging-of-unknown-freelist-ids-v2-1-5e6c3f63370e@imgtec.com>
References: <20261009-b4-improve-logging-of-unknown-freelist-ids-v2-1-5e6c3f63370e@imgtec.com>
Subject: Re: [PATCH v2] drm/imagination: Improve logging of unknown
 freelist IDs
Message-ID: <179257726029.217387.271775620928362253.b4-ty@imgtec.com>
Date: Wed, 21 Oct 2026 15:37:40 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: lW888u5C85wJ0PvoSeXjr4cJV74dWny0
X-Proofpoint-ORIG-GUID: lW888u5C85wJ0PvoSeXjr4cJV74dWny0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MCBTYWx0ZWRfX9X4j6TUK5GTe
 V591XMq0jChzTl+gzhsqpBzVdcPty+J3/hSg0Pr5FkhqLpQ7hhWRLGyxNHOUM3W6ADMm2jVrvhX
 Ofc/gM8O4npFKNrWQfJtX9WEUaUaB8YLZVl3c8M4XFtJAFpYGNqbI0kWufN/xFc05dmynFECnlQ
 M7gIHQUtnIi0bUdLGEkB2Tv2hdB0cyHk6vwalZOk2MTwF2UZwNp6e/2Q+caL8Hq17+/A0cevGSv
 TBEearyqp0O/p6aqrDqxpXPD7PXIso+ot9n5BgSwqOfNMVuYAYByZc7Fq32ekzs7UWmbBfmM430
 tT0i6HjvgSNv4p0cTL0QJbwNUKARqQ4prccTL6cmxcbg34ARSrzoVPgJWLlmOLw2YcbhvaSFQa4
 HTI6AeMdW5aW3hG5Zvz/j6vOxENFe10+D02kwPnW3YtlymqCOfWdW7fuwnwgMbEVzTA4jdI1Pzx
 12qzgk6nU5D4MILC3hA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MCBTYWx0ZWRfX5r646lanVyG8
 1XDa3gCk6Rfw3kJRYGg+FJwN3Ny6uM7GkSRjBtk7tnV16ARNM7c/xqvoSQE4t93Y2Mw6h1fDJVa
 98O43SId0PCC7F4PilwdJcBB+qOS5+o=
X-Authority-Analysis: v=2.4 cv=eO+GH3p1 c=1 sm=1 tr=0 ts=6ad88eef cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=x1VBDH5lXswA:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=wyhv_oTX6gE_ehOD5bEA:9 a=QEXdDO2ut3YA:10
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

On Fri, 09 Oct 2026 14:04:35 +0300, Alexandru Dadu wrote:
> Log freelist IDs not recognised by the driver when processing freelist
> grow or reconstruction requests from the firmware.
> 
> In the freelist grow request path, remove a WARN_ON() which is not
> particularly useful since it is known where the request came from.
> 
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm/imagination: Improve logging of unknown freelist IDs
      commit: f4fbf95c82ea6c3673bd5de38931f02474a38e51

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>


