Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A254CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C964A10EAA8;
	Tue, 23 Jun 2026 11:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="CBJRo/Ba";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CBJRo/Ba";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011059.outbound.protection.outlook.com
 [40.107.130.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D21610EAA8
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 11:19:06 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gIwwsxDHtIA6X2kVHhS0//QXCgjVW8fP/5KFQtmRjFA2VQEnlZqyStKgxnvo4D0C9U9/AG9UQ2Lzr1EVaypYhHBqSrqYlWH85yKAhhPbDh3oj5lsdy5KAXU+TGKykQSd50vth2rXEzX4hLrm4NLiVY2MsINuzWRo1YWbLZ72SbvBQxmuvH9L4ahxKXTpeqxb+nuMtIwEPwDqZFbXsmH/6CJ+AGtDMREPq22rliRND+u5YLLonRITlGIRCUUGoyu/03IkDKdpoUNH7a/gwCTKXGSuAPn+u/4v7sPpuV8GVs3q2F6tYlTJ9jb2B+lx/VQO/jGNnroJV2UzgMdzgm9gHA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx8k2yQOK21yrTfDWrYtlYz/J0FAMWY9WaqW0uMzGGs=;
 b=iCHb7nANZy0viPGR1JxhilUKO/dLQvupBczLrIk+/Tk3jTga0GU3ACof6EhfbsMj66+S7OGyiN9V6TQP9+9f9NBgURakOmpZBWL4oujM+r7p7slyE4iLhYDafryNNvCZMuUxHq07kptwcU0+ac1OBk0lK4sYxVV8Ld0bqW1arNsayN4tCx2HYDvoCh6DBQBbwVHqHgAsY193xt7IE2OhYDRYN0rRZI+B3agk4ISzZA2YOHjBa5be8BdxlD3O/5C1rhoAq25C0AmRidUsHN2dueI+NB0vW8sT+gHuptKnGgZTf2jt6Nlx7Y7qjgaOLlrVN4wYmYViEVtvKJ+9KmXbpA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx8k2yQOK21yrTfDWrYtlYz/J0FAMWY9WaqW0uMzGGs=;
 b=CBJRo/BaDhl+VUpUBsqv8ADoIwhr9SydM5NyOWefk9A7oR0G/juSQ/wNVEANyoJfw19unk8xa7GtV+qZiFn5otvokF+Ec6yPFWycEbSTIy918KTph5JjYzJpF74P0BZwWdSYZbpMjAwd4bc77JUinrNNzrtWvSka5V9pvb26LsA=
Received: from DU7P250CA0023.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::11)
 by GVXPR08MB11010.eurprd08.prod.outlook.com (2603:10a6:150:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 11:18:57 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::8e) by DU7P250CA0023.outlook.office365.com
 (2603:10a6:10:54f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 11:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Tue, 23 Jun 2026 11:18:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feFepatc1azAMel1nxLclZeRBBUCN7M1LU6v+pXkftYZKfDYtcBtfvtCtLExSEn8B4oE9iL4ukuyEj5aWCSvCABuzhk8UFWcrHLwyxkIiuY3rC/upMGCh6qn6MiVPv9wWOMSrooIbrhX/mTpKjzwdmsbnH0R85foca4UqVqf1EezDURlTPEe5KFJo5DEQRLTXE8SuspVMqRlOULs16MkJc8RqLOxhEWHyThbY5+mCTk4Q1aEj22z5Mlm+ajTuk+CHgMI5yYrqUwvPsIG0zR4F+xuNv/Pj/tfi0aSpNY2nXP3FaKSi5tF6Am67XyK7x7ah20Axjut4HDy11c10aNCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx8k2yQOK21yrTfDWrYtlYz/J0FAMWY9WaqW0uMzGGs=;
 b=wXcAiYVSS4UWYQyyOtw0ZF8qTjDjjqk80cHhN1bok2L7K8dpnhYkmLWV8ho14A9C0pxveoPNPzVcpaQ/tpmjJrH3ngmKc+YYP9zqQlkTLxF/zrn+MCA3VTvkCby3MQoe2owM/DbcXS6a131vrdzJ0/9dxQ6MunICAKfjGnyhg+bS2cn0QCyGgCDYpjuilP25keQ2bc91S2X+JoALrcX4SHqvjfj//ICvukz3Wlp57EzdZ+y/iGcncNeXYsLjt9rzPIT2lHwfM4sz0clH1kNBIycWWw4VsyD5xnH/hnWbJ2EQ54g3DcQZmLU2/BQYK3J159t5UrMN4C+v5qm0oR357w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx8k2yQOK21yrTfDWrYtlYz/J0FAMWY9WaqW0uMzGGs=;
 b=CBJRo/BaDhl+VUpUBsqv8ADoIwhr9SydM5NyOWefk9A7oR0G/juSQ/wNVEANyoJfw19unk8xa7GtV+qZiFn5otvokF+Ec6yPFWycEbSTIy918KTph5JjYzJpF74P0BZwWdSYZbpMjAwd4bc77JUinrNNzrtWvSka5V9pvb26LsA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com (2603:10a6:150:316::8)
 by DB9PR08MB9753.eurprd08.prod.outlook.com (2603:10a6:10:462::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 11:17:53 +0000
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133]) by GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 11:17:53 +0000
Message-ID: <9f9b372d-b465-4fd4-ab7a-9c399e35b4ed@arm.com>
Date: Tue, 23 Jun 2026 12:17:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Fix NPD issue on partial unmap of an evicted
 BO
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
References: <20260623092413.2710066-1-akash.goel@arm.com>
 <20260623115332.7e89f56b@fedora-2.home>
Content-Language: en-US
From: Akash Goel <akash.goel@arm.com>
In-Reply-To: <20260623115332.7e89f56b@fedora-2.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0648.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::19) To GVXPR08MB11744.eurprd08.prod.outlook.com
 (2603:10a6:150:316::8)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11744:EE_|DB9PR08MB9753:EE_|DB1PEPF000509F0:EE_|GVXPR08MB11010:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9f453c-4f80-460a-2aa9-08ded11937ad
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: Okn7G2Wzv64ucmZPI0ZagnRFRwIJmtvFQEOR9IuuR7CMLxFePRSFAZ8IgQAZS/KMy/vfVdVPTO/aGboYuZxOo7Wot7AKsOf8nycyUuQjNC3o10CSt/XA1vZHkdSkqvX6+1DfjKchrcabv/4d3uLUrhhAh97cKkx0gH0jqZX8iOuQsMsIAG9TQxPmTNUSJA7tHJh5ouIZDNwc4FF+itG/Hyj//cP72Wl1iI//m6YpTsASmafi5PycaL16Ne8+xWJaRrqqaiuTwJFUD7OM/SmDGWx18ojX+MPHmnVb3JutJt9YWZAKj2PKeWobU90IibbX+XEg7OPyHIzJYsm//HEJ5aeVolC5uvfHbcIz7GwyPttlpa4cNIiAk4nM135JdHJosAlX2LlPIakLEVPrAe7x2UdhrtQ3NWI/zyYfTWW4H+PxRjyf3DozKY2uC6uJ1h9qQbL1jCXsB7d9DFIub3znvnfRtdrbQY/P/WxswW5KdRibG316M6pMH6J9o/YvowGBOQy9DVlsKqsKKjWupWDatlcB1s8oikerbftEI4p9zgAOFAnXNGyJfAaYGAv1fPoBt0jT5aI4p2LuRGkieeILt9G4flfYymtHZ3VA2M54Co3oYn69j+iH5Y86cCxZkCko6VKvFuwh6uDmCcFkGz5Py3Z6lJWuJlVqO7mnKHem+yQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11744.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: YG3xUVuprpwMuxCp40yjfyvUdYdl5xyU7jC5GHaBnM+DM8LrB7m7U9qWgjTfHiL0pXKGTiuPh118d615MXW46TwaH7S+JnoZKEQyIkOKONKS4jgMSjkAa9ttzk5LU+A1bNplro+mpSUCivdvpDR50JdSzg/lntNLcRlV9acw5ibYrY0ZToKhPzV83ac4w+hAiPi54sOWEGsOUZ8mpJBMdo4sZmlWGKmEd2n81d5t+ZBZ8B/x2XoegbziHMHpQUxZPNnoJvoy7vCeQXytjn/fyHBfzYs1I8iU4Lue2hK6eEjO1xqiFo1xlY+UiDlKe/2SLlP4r2k/1bzg4Bjm7C6DEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9753
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ba6694a4-f976-4fa8-0081-08ded119116b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|35042699022|14060799003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: YL0eaETN1Vsvgcmm5SrB377W8bFAlUvm7au+urtA4Rz77YG7PRWgEECToEpDuXMTzEns8ns4A0QWNSQ8tYVaJU7aJlpl6IjiL4NsrA1pckQymghxmyQrdzb9c+ZLniqZ22wACGN0ne5TlVOEIAyfcZ0T+e4BwQDB2ZRO6xNXlGFcFoDFSBR0nwK0ift9UzSNyPzhmqJFzxJaRjDpJb1i00LS8aGjAzSWuVMr28tYud/nHuDkSUY5++Cv50teamYk7jniJPV8MWuJkREjo9e72snCNXrYphLcKCoL9O0usbjJi3PYZS77/WbxY+5WwudQzPKPrXL0T7GbFSIwb+HeXQLnKpyisdox/bZWO8yjEFm36IHEsoettHrwWGUPllI+Yl0AKRblopgcvQIegwWaQ8iDOhoQ68EXvndTRsDzbJ2NjorOBLdjc54sHpCCYJO+Cv92GIR5uwcSK3NAvr+Tf+wtHAic0qZw64wOG0YjXbuiEdP3+QIo17x2FxoMCNPslxpIqkORRGQc2Tjk9/UKrhkyN9Nsm3Gq6OYLFiExqUOnq1GL8yMcUVmKr8DR/pCQju5Z/BDLe6wD+tf8v2h1eI4eATSpeJfowPzfuEV8KdZvIdZsP3VOVgTzMUMOnMN9Aqd+/jMg4CC5MZMTD7yVdy+uIsOZy3xZXnCJUMKSP5heqGrTetY2sWK8M2apK7+gmTizSOVoes3k1T5Rh8puWQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(35042699022)(14060799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j0kQJWRkgwreAzNn8A6FUOBQzZLzb0r9YCcVhL97YYCsCYMcLMA9svo7ljtd54PW7BjT5Q1HhsP2Ovc3lr2o2TOMeqpREmZbNmuhJKposSZBfZdzY99wmGy5mri0BIT0ENfrS9kV8tI7rk26t2dWFcoVxIIzvKB6pqHIZDUyAXrIa5S5AMzlmok0Tzq6Q1RaSX0gd1W5G0uhDgu7qmDEBdahhhJWjFmQkD3NUqv/7b10I3TP+ixL1PcMpynDZTgrfHRiyhagkT3p6RwjkfBuIMG8oa1pvuhbbQHxGtniMOBsPuXL03x8bTOsMF6sNAGxbpyWhv02rEOwqfsKS4I9bAKyndn6BxWI8kGzeTc/hoYlJGz8k0HfbyXBE0oy5wFmgam8HMvlgu4ewikrhlFeVQIcepm06Qxlrt16ZK7AwvIIIBGfdJXi90CG58tycFcH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:18:57.0680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9f453c-4f80-460a-2aa9-08ded11937ad
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11010
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

Hi Boris

On 6/23/26 10:53, Boris Brezillon wrote:
> On Tue, 23 Jun 2026 10:24:13 +0100
> Akash Goel <akash.goel@arm.com> wrote:
> 
>> This commit fixes the NULL pointer dereference issue that would have
>> happened on the split of GPU mapping due to partial unmap of an evicted
>> BO. There is a logic to handle the partial unmap of huge pages when the
>> GPU mapping is split. That logic was not being completely skipped for
>> the VMA of an evicted BO and that resulted in a NPD possibility for the
>> 'bo->backing.pages' pointer, which is set to NULL when pages of a
>> BO are released on eviction.
>>

>>
>> Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
>> Signed-off-by: Akash Goel <akash.goel@arm.com>
>> ---
>>   drivers/gpu/drm/panthor/panthor_mmu.c | 26 +++++++++++++-------------
>>   1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
>> index 31cc57029c12..285e7b9bc100 100644
>> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
>> @@ -2358,20 +2358,20 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
>>   	 */
>>   	panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);
>>   
>> -	/*
>> -	 * ARM IOMMU page table management code disallows partial unmaps of huge pages,
>> -	 * so when a partial unmap is requested, we must first unmap the entire huge
>> -	 * page and then remap the difference between the huge page minus the requested
>> -	 * unmap region. Calculating the right start address and range for the expanded
>> -	 * unmap operation is the responsibility of the following function.
>> -	 */
>> -	unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
>> -
>> -	/* If the range changed, we might have to lock a wider region to guarantee
>> -	 * atomicity. panthor_vm_lock_region() bails out early if the new region
>> -	 * is already part of the locked region, so no need to do this check here.
>> -	 */
>>   	if (!unmap_vma->evicted) {
>> +		/*
>> +		* ARM IOMMU page table management code disallows partial unmaps of huge pages,
>> +		* so when a partial unmap is requested, we must first unmap the entire huge
>> +		* page and then remap the difference between the huge page minus the requested
>> +		* unmap region. Calculating the right start address and range for the expanded
>> +		* unmap operation is the responsibility of the following function.
>> +		*/
>> +		unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
>> +
>> +		/* If the range changed, we might have to lock a wider region to guarantee
>> +		 * atomicity. panthor_vm_lock_region() bails out early if the new region
>> +		 * is already part of the locked region, so no need to do this check here.
>> +		 */
>>   		panthor_vm_lock_region(vm, unmap_start, unmap_range);
>>   		panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
>>   	}
> 
> 
> I think we want something like that instead, so we can keep the
> 2M alignment for sparse mappings which go recently introduced.
> 

Thanks for the suggestion. But sorry I didn't get it.

I see that the patching of 'op->remap.next->gem.offset' would still be 
done with my change.

	panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);

	if (!unmap_vma->evicted) {
		unmap_hugepage_align(&op->remap, &unmap_start,

IIUC, the 2M alignment is done to avoid a potential partial unmap of 2M 
page. But if the VMA is in evicted state then already the unmap would 
have happened for the whole virtual range covered by the VMA.

Please can you kindly clarify.

Best regards
Akash



> --->8---
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 5e735995f80d..28844e1e2f81 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2301,6 +2301,10 @@ iova_mapped_as_huge_page(struct drm_gpuva_op_map *op, u64 addr)
>          const struct page *pg;
>          pgoff_t bo_offset;
>   
> +       /* Can happen if the BO is evicted. */
> +       if (!bo->backing.pages)
> +               return false;
> +
>          bo_offset = addr - op->va.addr + op->gem.offset;
>          pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
>   
> 
