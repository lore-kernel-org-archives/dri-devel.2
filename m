Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0DD108E1E7
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E2710E973;
	Thu, 19 Mar 2026 11:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="sHyTBZ2E";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sHyTBZ2E";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7748510E973
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 11:02:09 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pFKppbw5wVnIt5lKIiwKxGivqJwqJjbZHd3K4WKL/Al8+YXm6GpzF7RvDG0MXPXMJugOdV8/m/WovUeezEetRH5GcgH3vBeS03t0yJMqEF7VnxhXmtGtd2uVVVkWyNmvxcCCsu0BlK7FRVw9EGK5XqiRroahzo/2Ahk/HJdnMu3Nl7+0fWKNEUrnJ5EIsaKBh6jj7kVJ7r4+5RzUbWVPdi3lNy5/gR/WBgleZwJSYZlvU1ol4qgTo3uMM1/4wui8zSzC+kwgppv0Xmh2EbfAAqhOaFbC6BOAH6W5/RAbPbyDDTve/LMA26BvGbFKEm0QHAs6EPK/lRWommFPGFy34g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XaJ26jjOVpmAS/re42Sw1WW0YdLPDo/FXzoAgvuIOg=;
 b=p4awOyqvVvku3ToGXsLhCzxdlCXsSIWuRNuEHm/fBLycN0mS4dkvi6PP2IkuZgqj0Rme/cwVwX6nlhNNm8906aJlfdPkDEXIFL0u1ITcpu2uX8H81OJIWRkv1eHeLIkJrf2GXS12v7YySjQXUbCYMou0qYfqZ4HcXUQ8Ga/MGCVNy/cdzw3KwFRoKZuMkkjfgIvGjBZ+b8oobsxnm/mkufYEJ2289q8XL8CvAf/LCEFgiSUEWdKm+reVhuQIkVexlr4JFyrd8TyEZeaac8swts13jakn0xN0CCzaWy9sV8y0NwA2w+2GV2io07w2J5JQuWTK9vASdTq+d9VwcGOurA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XaJ26jjOVpmAS/re42Sw1WW0YdLPDo/FXzoAgvuIOg=;
 b=sHyTBZ2EbK6Kz1LON+IXZqSjCmOTUkHOF7s1uKXesyLsZ0n+7c2Yqp/nf8qgjTXCbTOzqQoIkBue4LyhEdGlSbeX7GNZy/GsOHr2GsYDIpW7+sTXChMI520mAYuJwWTvEnqYm4NLJUuKnIFIx4WOpWzsGD6oUVf2IriTreg4ADk=
Received: from AS9PR06CA0355.eurprd06.prod.outlook.com (2603:10a6:20b:466::22)
 by PAWPR08MB11066.eurprd08.prod.outlook.com (2603:10a6:102:46b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 11:02:04 +0000
Received: from AMS0EPF00000190.eurprd05.prod.outlook.com
 (2603:10a6:20b:466:cafe::9e) by AS9PR06CA0355.outlook.office365.com
 (2603:10a6:20b:466::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 11:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000190.mail.protection.outlook.com (10.167.16.213) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Thu, 19 Mar 2026 11:02:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVhKhOHKCeATSRVN+yjbgR9rhpnpbWohKANTSWo5tUrAB7Q5lYSv+Lq2IhzAlBTqutf11AVXX6yDRrT0mCtHrAIImR+bc//JEPa5Gn8YZFZU64EtSGiqbbA9D76tjUu5s4+pXEEjgoWMD2e11pQj/9yhirnmS3EvVvlR8bvv03jWMQHsQ8B8c9ty/EA4YHtkMfSa8NP/hbuBhlDr3N9cKSrT52T9y9gwLjMSH1qLbMo8CYVEqA3RZKWl2QH7IsrxmFfoC1oeFCIwzotZt83v4N+8HRBs4NQ0I16aoXteeW7J+cOl9NohxBsYaeeUSqIaruuChwuHgXqW4nQR6/wUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XaJ26jjOVpmAS/re42Sw1WW0YdLPDo/FXzoAgvuIOg=;
 b=WyeaGvASfS+yLUzyUi2tcns1YQM4BeheEbyY0OCO/10fD9TMs64LZ4jgR7MyIRqGHo0Qd6IAWVdjJE0drTN5gwIt3yVPqu2dv6TRpOgqH3woeS/fUEBP3atA37mF0J0dF+vLQr8IuMEr+1X35Yj8WddPdOyM+yccyncHHR2Wv+nnAnVSVn3++2OGifMVDWTJMwXSlLXA6LmvvpRNse5f7UJ82bqjyl8u56tKy0MGdHITCz0qyGa8/YM3YOgZJS09gTft15rMXSauSm4OKWnQEQseUcMrLW9HUmpRfW01/uo0KwU2529RfKltRLR60DejPThkt5/vbvRfL9t9dzhtgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XaJ26jjOVpmAS/re42Sw1WW0YdLPDo/FXzoAgvuIOg=;
 b=sHyTBZ2EbK6Kz1LON+IXZqSjCmOTUkHOF7s1uKXesyLsZ0n+7c2Yqp/nf8qgjTXCbTOzqQoIkBue4LyhEdGlSbeX7GNZy/GsOHr2GsYDIpW7+sTXChMI520mAYuJwWTvEnqYm4NLJUuKnIFIx4WOpWzsGD6oUVf2IriTreg4ADk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com (2603:10a6:102:35a::11)
 by PA6PR08MB11582.eurprd08.prod.outlook.com (2603:10a6:102:522::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 11:01:00 +0000
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f]) by PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 11:01:00 +0000
From: Marcin Slusarz <marcin.slusarz@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lukas Zapolskas <lukas.zapolskas@arm.com>,
 nd@arm.com
Subject: [PATCH v3] drm/panthor: extend timestamp query with flags
Date: Thu, 19 Mar 2026 12:00:53 +0100
Message-ID: <20260319110053.909152-1-marcin.slusarz@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318112952.645160-1-marcin.slusarz@arm.com>
References: <20260318112952.645160-1-marcin.slusarz@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0517.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3db::27) To PAWPR08MB9996.eurprd08.prod.outlook.com
 (2603:10a6:102:35a::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAWPR08MB9996:EE_|PA6PR08MB11582:EE_|AMS0EPF00000190:EE_|PAWPR08MB11066:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ca24c3-cad0-4d89-2399-08de85a6f400
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info-Original: X4y4zP2D9kmC4baJN81nkWsU4YnWjL2dtbAN2HBlE1PzIkkNpD0S/R2AbLvG+RACBhtTmL9BXbUG+uIPG+pOpPPMFjvT/WVIKasZU7nYBqfN4xRtbm36PeBeVHWb024C10/PNDtztobo+vMOIAtnrKzJiTHPZsW7R1dqoue/yM1GP4TXb7APXkJHPa4NnXOHqjKuG/PkRQIIQOhvW4ZZ0JeMQwB4kGnLnuqwsG1v8YKs5kjGOylnAEokwTpwCPnVunQ94d1yHAUrNpOGYpp+orPKhwrSsIivdkMhH0nWSncIWIGkpGu/UkFXy6XgrEvutPbhpDqqitApW5P3jeO7kwlqW3NDhW7tGwb+RwY9TXMEU4QNkUNHQiE/lwCuqk4eIkSoQJTLmhpVifYyXnlfvcTr2R5e7Vk3mB+gPrY7zyndsBEYX2IJl8KMYokqkD6XGwiozJD2VutSZcZMjQPJiIZSKJqIoJWkFuq8cD785yTxkY5/DegHJ6QZOjKD0UGF6Y0Gs6+tFRq/cBYddxaQa7U7/2wupgGeI5FB2CSbKt0GAqm6gAIVCMRH+psJ8u1Zqk+UdmxgkEqmkKDXxuSC+31vDQj4lwAzspY3U5VUSLdOAXvHzptsADbcVe1y4A3ca34nlSVYztpHvaHymTNsg8TZFwNg6qspXD4X25pIeYeV7+ewiUDLLM4hUWBUXrg+kk0BXUugFTKTq8f55dqm0vf0BLReJU5SZ9pnzPyN6to=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB9996.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: lq1RYYtM5JghaYs5seEFNiFy04EMGmAfVVhoR/EQ+J2O+hH3TVawhs/GrpQqFVsM5qrbzDcwZcx9KvC4RqvdU9epccBcYrbWTI0JA86AO44i1I85y63+N1FacTreIiUA/JIA4l2dyyMoAj/Gf6AfPIKJPqC6FSAPrIM+wCAT7sbEkIKMwaO8D8vXx5ljSUrEYWCmdIRYyNf1+JOWLN9xdCl/niwsZ1BAeCYG1koBpi+angeNIFTgWoHrdjWlLdANm59BLUvsewbabKrsI0ehA2cXlGVl97xTsICyeqYL3SdDaqaUtn7kcXP6uaE4hRU5iCQo81znbfPJpOfpTWNvoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB11582
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d7ceddb5-5790-49bd-fe5e-08de85a6cdbd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|35042699022|36860700016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4M/qouPV+VN+We2Z8oXZkHqBNAJRA9loQquCOhgHO4bj4yhDQrxG9lfw8IqfnfxU1LMcXgWKs56RBMLjQjYcalE77LzmSnJsKgEz9tWrCPZjF0Eg8aDn/oH0vRMWYwbWYyb2Pn6kv7155Cg2Rd/bsEyfwbt1hQplYElolsusSP/0CWwEUXKsU+vaHwHnA1YBVm3JUs1kXCg43lKfHzfrhErgLz03/cWFKc7yzzVzYPwl1eM3H6NY/tJIbcm58X3EFZK2inpeQhXK37Il0jf8QUuhWvMhhSCJMhXzMRhGiSXFACd8LsZzuKZCruP5lMG7CdSwq2fLAWRX3aH2mknjBgFec7JI+FRtKzRWwJxDThKpf70BLzT9hXFzBsC2oQg4eIs5La2PCRCSYNrly+0EVbEs+BPyX/4ewdaEZg1V+Mvz+wEr+VGTCpBBo2W+QGsQorsAERKlJyqh9euRoVI0SnCF7lsHmSrily2Uu58R16aNmBMiCInJNjRUXd/rwoMLl0rV9vOq//hu4jy8gG4TNdh64pYK2aXNnzyaJWOX7ljHXmTBepzSGcd6TlPJsDQUvyYZosgbLSX0HvIh6GI6YRcz27ogknr43FvhfNvIqjqjonb0Hw/OqNUrLS+A50bk/87sqt4g8/h052xLHaASBhaMpQ/AzaXzMp7LcXhxvs5+WQbBTa+pJlI0JNUOrGNgqg0LHk5s/XxdXNkrn7LtonGVU4CTEl1S+5O8zCk3EJLLN8prwV4upj3TWLOOkGDTqmnqMyqunhPoUJkyHGcJNw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(35042699022)(36860700016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xz7wAlMShfTcObAMHWp4+V06SBx/kRyl27fwdKZF5rxw0l9ySJP/D5u4CPJYf8sYds8ojXfz8/Iy+nGASBOHBwJV8c+xdcwomAi9qKE5blhG9X3M349+acoTnevOsHVxFR0izyF+mR4wY+oN+kGaBsBjn7KfBn+PxZuF9PPE1Tg1Y5HeczCBY1F/6z0utKRhYHvIocU1mJIXf0apbHZ/VYbwQldKMegaYFf9l6cCPASjPHimdpMGZBCyDIrLufWzepAIHq08F3K2ZkOLaf1tfVoSWEIaqPMhvc1imy6hJLAnJo2KQrye7nCjreyrXzqIUBrobBxBrK0hxxlzg7Pp9Nrb/kTDGnmffIk8llj88utPxgZEvCYFteGFY5UUxUb5eIzmuF6Dhb5IkRb1RgtHNgMZuamyh9H8+HWtkWNj9AAvNIKLAUBxab8RI3EHAnJL
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 11:02:03.6752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ca24c3-cad0-4d89-2399-08de85a6f400
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11066
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

Flags now control which data user space wants to query,
there is more information sources, and there's ability
to query duration of multiple timestamp reads.

New sources:
- CPU's monotonic,
- CPU's monotonic raw,
- GPU's cycle count

These changes should make the implementation of
VK_KHR_calibrated_timestamps more accurate and much simpler.

Signed-off-by: Marcin Slusarz <marcin.slusarz@arm.com>
---
Changes in v3:
 - {} around multiline statements
 - added comment about default flags
 - added VALID_TIMESTAMP_QUERY_FLAGS
 - used u64_to_user_ptr
Changes in v2:
 - added DRM_PANTHOR_TIMESTAMP_CPU_NONE
 - cpu_timestamp_nsec extended to u64
 - pad1 removed
 - copy_from_user -> copy_struct_from_user
 - looking at size replaced by looking at flags
 - more comments
---
 drivers/gpu/drm/panthor/panthor_drv.c | 134 ++++++++++++++++++++++++--
 include/uapi/drm/panthor_drm.h        |  58 ++++++++++-
 2 files changed, 184 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 165dddfde6ca..029ef3295b06 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -13,7 +13,9 @@
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched/clock.h>
 #include <linux/time64.h>
+#include <linux/time_namespace.h>
 
 #include <drm/drm_auth.h>
 #include <drm/drm_debugfs.h>
@@ -761,22 +763,135 @@ static void panthor_submit_ctx_cleanup(struct panthor_submit_ctx *ctx,
 	kvfree(ctx->jobs);
 }
 
+#define VALID_TIMESTAMP_QUERY_FLAGS \
+		(DRM_PANTHOR_TIMESTAMP_GPU | \
+		 DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK | \
+		 DRM_PANTHOR_TIMESTAMP_GPU_OFFSET | \
+		 DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT | \
+		 DRM_PANTHOR_TIMESTAMP_FREQ | \
+		 DRM_PANTHOR_TIMESTAMP_DURATION)
+
 static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 					struct drm_panthor_timestamp_info *arg)
 {
 	int ret;
+	u32 flags;
+	unsigned long irq_flags;
+	struct timespec64 cpu_ts;
+	u64 query_start_time;
+	bool minimize_interruption;
+	u32 timestamp_types = 0;
+
+	if (arg->flags != 0) {
+		flags = arg->flags;
+	} else {
+		/*
+		 * If flags are 0, then ask for the same things that we asked
+		 * for before flags were added.
+		 */
+		flags = DRM_PANTHOR_TIMESTAMP_GPU |
+			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
+			DRM_PANTHOR_TIMESTAMP_FREQ;
+	}
+
+	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
+	case 0:
+		break;
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
+		timestamp_types++;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (flags & ~VALID_TIMESTAMP_QUERY_FLAGS)
+		return -EINVAL;
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
+		timestamp_types++;
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
+		timestamp_types++;
+
+	/* If user asked to obtain timestamps from more than one source,
+	 * then it very likely means they want them to be as close as possible.
+	 * If they asked for duration, then that likely means that they
+	 * want to know how long obtaining timestamp takes, without random
+	 * events, like process scheduling or interrupts.
+	 */
+	minimize_interruption =
+		(flags & DRM_PANTHOR_TIMESTAMP_DURATION) ||
+		(timestamp_types >= 2);
 
 	ret = panthor_device_resume_and_get(ptdev);
 	if (ret)
 		return ret;
 
+	if (flags & DRM_PANTHOR_TIMESTAMP_FREQ) {
 #ifdef CONFIG_ARM_ARCH_TIMER
-	arg->timestamp_frequency = arch_timer_get_cntfrq();
+		arg->timestamp_frequency = arch_timer_get_cntfrq();
 #else
-	arg->timestamp_frequency = 0;
+		arg->timestamp_frequency = 0;
 #endif
-	arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
-	arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
+	} else {
+		arg->timestamp_frequency = 0;
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_OFFSET)
+		arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
+	else
+		arg->timestamp_offset = 0;
+
+	if (minimize_interruption) {
+		preempt_disable();
+		local_irq_save(irq_flags);
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_DURATION)
+		query_start_time = local_clock();
+	else
+		query_start_time = 0;
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
+		arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
+	else
+		arg->current_timestamp = 0;
+
+	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
+		ktime_get_ts64(&cpu_ts);
+		break;
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
+		ktime_get_raw_ts64(&cpu_ts);
+		break;
+	default:
+		break;
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
+		arg->cycle_count = gpu_read64_counter(ptdev, GPU_CYCLE_COUNT);
+	else
+		arg->cycle_count = 0;
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_DURATION)
+		arg->duration_nsec = local_clock() - query_start_time;
+	else
+		arg->duration_nsec = 0;
+
+	if (minimize_interruption) {
+		local_irq_restore(irq_flags);
+		preempt_enable();
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
+		timens_add_monotonic(&cpu_ts);
+
+		arg->cpu_timestamp_sec = cpu_ts.tv_sec;
+		arg->cpu_timestamp_nsec = cpu_ts.tv_nsec;
+	} else {
+		arg->cpu_timestamp_sec = 0;
+		arg->cpu_timestamp_nsec = 0;
+	}
 
 	pm_runtime_put(ptdev->base.dev);
 	return 0;
@@ -851,8 +966,14 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->csif_info);
 
 	case DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO:
-		ret = panthor_query_timestamp_info(ptdev, &timestamp_info);
+		ret = copy_struct_from_user(&timestamp_info,
+					    sizeof(timestamp_info),
+					    u64_to_user_ptr(args->pointer),
+					    args->size);
+		if (ret)
+			return ret;
 
+		ret = panthor_query_timestamp_info(ptdev, &timestamp_info);
 		if (ret)
 			return ret;
 
@@ -1680,6 +1801,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  *       - adds DRM_IOCTL_PANTHOR_BO_SYNC ioctl
  *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
  *       - adds drm_panthor_gpu_info::selected_coherency
+ * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1693,7 +1815,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 7,
+	.minor = 8,
 
 	.gem_create_object = panthor_gem_create_object,
 	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index b401ac585d6a..8a46ef040c3d 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -409,6 +409,38 @@ struct drm_panthor_csif_info {
 	__u32 pad;
 };
 
+/**
+ * enum drm_panthor_timestamp_info_flags - drm_panthor_timestamp_info.flags
+ */
+enum drm_panthor_timestamp_info_flags {
+	/** @DRM_PANTHOR_TIMESTAMP_GPU: Query GPU time. */
+	DRM_PANTHOR_TIMESTAMP_GPU = 1 << 0,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_NONE: Don't query CPU time. */
+	DRM_PANTHOR_TIMESTAMP_CPU_NONE = 0 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC: Query CPU time using CLOCK_MONOTONIC. */
+	DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC = 1 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW: Query CPU time using CLOCK_MONOTONIC_RAW. */
+	DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW = 2 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK: Space reserved for CPU clock type. */
+	DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK = 7 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_GPU_OFFSET: Query GPU offset. */
+	DRM_PANTHOR_TIMESTAMP_GPU_OFFSET = 1 << 4,
+
+	/** @DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT: Query GPU cycle count. */
+	DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT = 1 << 5,
+
+	/** @DRM_PANTHOR_TIMESTAMP_FREQ: Query timestamp frequency. */
+	DRM_PANTHOR_TIMESTAMP_FREQ = 1 << 6,
+
+	/** @DRM_PANTHOR_TIMESTAMP_DURATION: Return duration of time query. */
+	DRM_PANTHOR_TIMESTAMP_DURATION = 1 << 7,
+};
+
 /**
  * struct drm_panthor_timestamp_info - Timestamp information
  *
@@ -421,11 +453,33 @@ struct drm_panthor_timestamp_info {
 	 */
 	__u64 timestamp_frequency;
 
-	/** @current_timestamp: The current timestamp. */
+	/** @current_timestamp: The current GPU timestamp. */
 	__u64 current_timestamp;
 
-	/** @timestamp_offset: The offset of the timestamp timer. */
+	/** @timestamp_offset: The offset of the GPU timestamp timer. */
 	__u64 timestamp_offset;
+
+	/**
+	 * @flags: Bitmask of drm_panthor_timestamp_info_flags.
+	 *
+	 * If set to 0, then it is interpreted as:
+	 *  DRM_PANTHOR_TIMESTAMP_GPU |
+	 *  DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
+	 *  DRM_PANTHOR_TIMESTAMP_FREQ
+	 */
+	__u32 flags;
+
+	/** @duration_nsec: Duration of time query. */
+	__u32 duration_nsec;
+
+	/** @cycle_count: Value of GPU_CYCLE_COUNT. */
+	__u64 cycle_count;
+
+	/** @cpu_timestamp_sec: Seconds part of CPU timestamp. */
+	__u64 cpu_timestamp_sec;
+
+	/** @cpu_timestamp_nsec: Nanseconds part of CPU timestamp. */
+	__u64 cpu_timestamp_nsec;
 };
 
 /**
-- 
2.34.1

