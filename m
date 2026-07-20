Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7CEC4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4AAA10E940;
	Mon, 20 Jul 2026 13:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Lz8zt24v";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD05C10E940
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:40:21 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDQ7kM2867390; Mon, 20 Jul 2026 14:40:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=v
 wMIuxtZ+xQVDTuhvprFppZFGHGni2/xd55VFQYMBSg=; b=Lz8zt24vA8pXptDYh
 Y3Y9wTIUy+NStW9ssyCGnpN5UHd0nlv/5/433kdvilkFDpS83BHC2YcXp7NH6kcy
 EoaYVhjHLGCNU1XrFl7m/DiesHe5lKTn/INqtSNBm0HXGdu0hW3DJM+yCmeRxRiZ
 XolB3/1s71SVKp53LigXYz/j3aE6IKBd2JwHXzSpOQKMEwsOZWE/iHubHSnjCoWO
 OWKDB0np3qt6Z2tWnF+UmZ/YoY+mSL07p5K3jnQo+6ZQOvCFpxLARCkLibzS9owR
 pmbGpkI43xJGEnWMg3oVutIs6+pOhNe7N0ajaJ+XL5/CduTd6Wx5h5yyEa8aPj8M
 sD2PA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fg1ju9t68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 14:40:06 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.9) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 20 Jul
 2026 14:40:05 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matt Coster <opensource@mtcoster.net>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20250709-flex-array-check-v1-0-8adeb0bf0cde@imgtec.com>
References: <20250709-flex-array-check-v1-0-8adeb0bf0cde@imgtec.com>
Subject: Re: [PATCH 0/2] drm/imagination: Fixes for flexible structures
Message-ID: <178455480506.416610.15755076012823290379.b4-ty@imgtec.com>
Date: Mon, 20 Jul 2026 14:40:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.4.9]
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1MSBTYWx0ZWRfX096LLOa/cxD/
 +Ws/cN23gApLjikhpLy0H8EBRDjVZaFQcZStdiIlwAi9yA6f9ynKiXt2XaLDDkQaVtLKTAljkoh
 ZCjjbJyrbNOzhzPgnPB8VxtPJaWbkbo=
X-Authority-Analysis: v=2.4 cv=Ta2mcxQh c=1 sm=1 tr=0 ts=6a5e2536 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=rvaOABGgyOwA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=Fjqm0qLoUvGMQChgWqIA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: ssBRiwVgvcnUr8TQmxLx3sexsrxD1pHr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1MSBTYWx0ZWRfX9CBJYZCCbRel
 Qg+HSFmQQbOvBh0bPHpGP35R8M2vHL02Un8QWC5KNWYe9YbQDsCKNjr+KlVM1l/+FGgXBa95LVB
 3yyrhLTjT5HAcyGvIrSzvNeE4u/cjArDW9V6w2484NtN7MDXuWGxM2zlZd57OU9i1xB6rmM89Ma
 QVWGIBr9VGonsC9oEX1Z1zv9QegJode1OYhUUT8WMce2GuITIVXfLzrHFpTMgKwKRFy2uksINbD
 kcc1jRrnvSpQAJnAwT0eCeq2KisIbVGbwpO4Svx+DvixU/D2Zj4499RG0BAh9gN1dgbUQ62SbU0
 Gkc8hoo0KA3JDTUDjHBERWzdVQfWdi+bP0meoojI4IKRE9wLmvnj9Iqcbtd4Hx7OYm9XezuMayv
 phTgGuXja8N1UVQuUgkcIsDyxj+sybzasEp513Z/CPte6QM08vzRfotQh4zlh7L7pcA3XKQGc//
 nuLisshgiGZqs3Ut8Bw==
X-Proofpoint-ORIG-GUID: ssBRiwVgvcnUr8TQmxLx3sexsrxD1pHr
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


On Wed, 09 Jul 2025 11:04:08 +0100, Matt Coster wrote:
> These fixes were made as part of investigating the Sparse issue reported
> in [1]; specifically that the sizeof() check for the flexible structure
> struct rogue_fwif_frag_ctx_state was failing under Sparse.
> 
> This is actually a fairly pointless check, and the discrepancy is
> related to the implicit padding at the end of the structure that is
> never used due to the flexible array member. A far more useful check is
> to assert that the final member is indeed a flexible array as expected,
> and that one element of said array is of the size that we expect.
> 
> [...]

Applied, thanks!

[1/2] drm/imagination: Add and use FLEX_ARRAY_CHECK()
      commit: f41ef8e3c65f1c424004493f7792ce06daa147df
[2/2] drm/imagination: Use struct_size_t()
      commit: b67ac31d7f42b2b2e9ca77c66bbbb3646f039103

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

