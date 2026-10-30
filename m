Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715F606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=YVrbptK7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE4211268D;
	Fri, 30 Oct 2026 08:40:12 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 485AA11268D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:40:06 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8G6Q7557406; Fri, 30 Oct 2026 08:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=8
 oS54XVS99i+9N1HcwjATWp2jSqRRknqP/3EMXP6MwY=; b=YVrbptK7nofPMOzp/
 /lyID7ilR6HLomQwPxrj1ILh1AHo0DHZYiSryyClG1JTZ6LOY6r23KqWnyDma5It
 TBKiyS8v8gjYt6PE52YnTssdGs//f2d4/qz2R8LKY8y/C7wmG60LeWeBgPIWyfFz
 YP40Os4Dm7Kj63506Q3m42iWHGJaCCDua4uv6fMpA8zikc6GldMq8Lx8C/NTdUBb
 vy5zxYFxFycc8nExe42B28lQ9KXnmo5zJKYjQaQaDWrAnYQGX2GDVa1E2BBjO28T
 8Fz0YUvPPdJQQb5zi3eNBPRvSR93CMPOcrrPAp0IRxk1nsgTvxgowkcOzLIbRr3U
 NcYxw==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hmcee0ctp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 08:39:49 +0000 (GMT)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.2.42) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 08:39:48 +0000
From: Alessio Belle <alessio.belle@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Donald Robson <donald.robson@imgtec.com>,
 Sarah Walker <sarah.walker@imgtec.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, Matt Coster <opensource@mtcoster.net>, "Michal
 Wilczynski" <m.wilczynski@samsung.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "kernel
 test robot" <lkp@intel.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>
In-Reply-To: <20261029-fix_imagination-v4-1-689745dd52ef@samsung.com>
References: <20261029-fix_imagination-v4-1-689745dd52ef@samsung.com>
Subject: Re: [PATCH v4] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
Message-ID: <179334958843.48356.5098117179149056889.b4-ty@b4>
Date: Fri, 30 Oct 2026 08:39:48 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX+sQBUcRN180i
 WGXSIWhLPcXzCtkMqgXUTOViE1C8nDvF3412kI/cFMlcwxRzT6sg1csb2pCg8OrlSnzJXDcZH2o
 9QItOistGvI6QOVD499clYe/sNFvEaKX85IH332XYvhUwqTlzTmNzZUMcwyYJi4Htzj0loSPXVp
 JSbAQui6BxNHXr6C9YJub3kmDe2mAhS06DwBZu8KopLyJiVp+hh7KA85u+XL5Qhmn3t0gQVHPyo
 T4RUbgJ3WrvjgVCtDh+Bwsg5LGtgzGnmh4Qs2Pr/tTfVN1TRzDtcdXCmKbBw47d0Ptp6kklG9lp
 psb8jV82doTX5K/y3MZzBTsYqRfk0efeiap9bZBBu32EK9aG+rtJngadaIuenggL29hP83odxvf
 TOdAbxv5RuuzRGTaozhKCe/UcIh2qLWBgTTT6RKhOND8VRQDlErkj/R/lcbHrEfeORIWVSIgcS7
 M8zbX6GGJ4RDuYIWW6Q==
X-Authority-Analysis: v=2.4 cv=a9alZkSF c=1 sm=1 tr=0 ts=6ae457d5 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=_X9-3wFeGQYA:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=PDPf7ECf0n-Q5fV5cTcA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: yiOVoJUd0F9FSO0JkehLh3JOK_kgIG9j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfXyO6iGIsswSZN
 7EWmENouHqD6CzP5AsBInVLL/+FkuMq/DY9Ymy20q2HTH2JkECHJW2ktJ9YCY5uiwbALorDMlx1
 mZXddH2JKxkpmuO6nitOaiMZntEFjlY=
X-Proofpoint-GUID: yiOVoJUd0F9FSO0JkehLh3JOK_kgIG9j
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

On Thu, 29 Oct 2026 09:17:18 +0100, Michal Wilczynski wrote:
> Sparse (W=1) builds fail because `SIZE_CHECK(struct rogue_fwif_hwrtdata,
> 384)` expects 384 bytes, but the compiler generates a 336-byte
> structure.
> 
> This is due to an alignment conflict: the inner member `cleanup_state`
> requires 64-byte alignment, but the outer struct is explicitly marked
> `__aligned(8)`.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/1] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
      commit: 6c6200ffebf9766fd5d9293002298ea371c261c1

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

