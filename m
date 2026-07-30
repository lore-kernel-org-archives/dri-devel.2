Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED66C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 04:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9305410EDAF;
	Thu, 30 Jul 2026 04:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="W0d73Jfd";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2835810EDA5
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoWLmYMg+KnWy/vah8N3+GvHzCIWI+gWjoYbU4RVymIKkaOo90KWV7JH8jbPgzuI11jYuE+J3DnPBIfxCVlZvSLjd+uoH3kBvmTiPn342azeWtEC1FqOrIOI46Tffq+l3ZxysDoW+uRcpFK1vgKVHvjb94iEP17zoY8yAIzVPXhw+kxu6RzQIXP/PiTg+BOcTwFVYdK9UBz0dZywYEQa4z/UrPDSveE6ez/U074oswbTn4xNnmMqiXW8pDf65xOU6hkK3xJC6SLaxdEFKbcLGujxlFsLh76SSO51Gh7X/98e5EJ8NUj3aZ0bDSqHOcdvqXv1+jchmvDyvdlqSQysEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0agjg29gT9SRgdv6tjn621N/FPbMOzl7h3vT/3urJM=;
 b=VwX6FwCYtQM9L3CotfzOPdYl/saiOWZ89HcVS4Jrso0mFzW6fRIEK6R7TeX/CjNq4a1zJMm97lgdKau4EukiqaA5xR0HUMPR+G7dOXO4PJWQA29v7YxjxLRFkyW9TWqfxUoS5gAcY+3RIL38ttvNKzbWXDWocKq0E/TKzReOOFr+N0LxGlhp/7tSvJYvkAxs8B0PvIumgkfy8Z0uVj/ew8Y27pmV2uLWPccBwdxKyV/m2lN6+6+12Xzng7CsFhmf6IJ/WzL7DxV2CPr5XKPUNNjn7leANrKpV6u8bJlFXs0YH5l/i+Z+eNO+2apD38EpzE1oAsVy6I/SQxG8zRNdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0agjg29gT9SRgdv6tjn621N/FPbMOzl7h3vT/3urJM=;
 b=W0d73Jfdzn0lZm7exX3DtiSIJK+NxY1257OCQLDr7aL+cmok0ThFeMivB2UKjx1gLzW1N3dHESHF274obHK2EoqUNd+BBHC41yM6ZnrBTzQkr01PO4j81PeW0+t1mtT8KbF5sGH32hUcl9GcawzTXnp9GRwcjyigKUgHLBJglA/wZEnW9ASGnNN4WGFt0EekUjtnssyj9EL1k9JpRyI+wxyIwoz6kcywcDofGuZ68NF7A2uppTtP8TNMNgf64oVBDPQy32DfMNqkXO34JvfivQg1gjQAHboFLZpmr/KKD85uy1g6b7y9B+b93Dj/D/pHiUdQumH0U0uXkCdkuDCpJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 04:46:16 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 04:46:16 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 30 Jul 2026 13:44:45 +0900
Subject: [PATCH 5/6] gpu: host1x: Add host1x_fence_extract()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-b4-host1x-syncobj-wait-v1-5-afa730410392@nvidia.com>
References: <20260730-b4-host1x-syncobj-wait-v1-0-afa730410392@nvidia.com>
In-Reply-To: <20260730-b4-host1x-syncobj-wait-v1-0-afa730410392@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb"
 <linux-media@vger.kernel.org>, 
 "moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb"
 <linaro-mm-sig@lists.linaro.org>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY4PR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:405:372::12) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 66808cac-863f-4d91-d9c1-08deedf57d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|22082099003|18002099003|5023799004|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 3Hf8VXRFUVIV2qsDT0he0wVhg4WTW5aDJYLIb2EAtyyjNEzdY8REeo03bo/ZAyVB/IzAGhJaqF/fHgispIMt5SdO7w8ilCNCKhAkcFb3mgZsmg0ih59+0MmXNY5m62MdYUHwhWiSQ1hkYkB2Oqkj0bWnLOnYTC2N+kGeX4jI6cUGhRow48wdOnZEARaLL4F0FlcHc0niqnFJHEzawf+wbzUA4hRuYOdzts65WiOSQ62faBluC1VXFhUUvXnJ2u2d/5avoD3SmY53cYsfPnUxmubesx7UpHlf6xjHJRTjUWNPaXj6KD34V1IA5dru95fDApf8cPzuH6FEsSse71Iux6QxIYgnxg86y2Dhv9uMzZMjT5vSa+P4WW1/X1q0HFhotCja+EH+QoorXgd7SAOrfVNqYhvrpz1sNxqKQ+CN9RcWWmoxbdOQnHpzLBYm6sfPHR2m/++JMlQfWctEpIggPINSWNfMldSey0y3pWxyjVnD+xmXlhyUI1RMT2m+V6W5KVYEKzB7DfspRQG6ructw2otw91E8yp4NGWJ+GQ8mAMsOmP2AUBVF0/FHLt6pg9B0fSEHORGNAXIMf41LBeEVDzz1loqy/vxxjq1VHuJIZ4ee+BB6ffnGSN8kBkbpor7LZLIXqadsr6oFisGL8+EaGA6IUhlRlUjcfU8OiZEmfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDAwTnpRMEoveFpkS3Z0NFF0ZUdaSk52c2hRRzBmRFpldnhXbmhieXF1S1dt?=
 =?utf-8?B?ZHhrVlJyRGlWK09zRGlWb0hiZUY4ZjVxS08xTE5hTmhxakF6MG9lYXM4bDl6?=
 =?utf-8?B?RGo4M2ZKRHg5cDdtTFZGOWM4akRaQWVDZlc5em5GNzJTeUUxMUpMQnA5a1Bx?=
 =?utf-8?B?L2l0UXNqSlBxSkFBU291NU51ZGJrZWsvTTNjaldFYmVoM25rRk8rTGt4b1R4?=
 =?utf-8?B?dkxlMkZZRTh3WmhvMCs4SW5VT01SdXR0ZXpKMzJBbE5jaE9iME83c29Bc2h6?=
 =?utf-8?B?U0M1UEd5VlNLbS9remxMeW5BZEhLRjg3MGpmbm9ZSjF6ZXBKNWlBUGlySUpk?=
 =?utf-8?B?VWhEVTJSU2dGcXhUQWtYTStuK3M3SXFMdWd0M0xEbVByQis2MzZXcEpjUThS?=
 =?utf-8?B?VEVFYUlDNnF5TndyU05yVllGaWNpdG14YzFGOFpHQmlHU2dab3d6eENsU0w2?=
 =?utf-8?B?VU0zSlpleldCSVBicVRTMUN3NE5ITHZyU3VFenQyNU9SakNmbzhjVWU2bW9i?=
 =?utf-8?B?UzE2SVpFdXFlRzB0NWM2d2NsRGdLVmg2SVJXN1V6U0RIc3J6Mkl2dlhYTVUr?=
 =?utf-8?B?MDkwL0NOL0hsbWlsaXhKNkdIS0dTczQ2N0kweHNFZnVTTlplVkFST0ZGU1pm?=
 =?utf-8?B?aUw2SlZKMEh6YzJPUFZQNmJoTmxPZUpEcWlQcDRMSTNRa21Yc3NIeXdneHBL?=
 =?utf-8?B?QUlSUjRiclppVHBQcmI0NXorTmJ1L01iby84MmQyMHdlY3RIckVFMGtBeUUy?=
 =?utf-8?B?TWdVb3M1cVpyQnhpOHRyckRzVFcyU0FUbHRxcG4zMDhBa21QRlN4aURDYlpj?=
 =?utf-8?B?VzRndjRvMTdNUGNyWXk3RVE0Uk9Laml2bTA2R0lYZnhQeUdyblFvRkIweTVQ?=
 =?utf-8?B?VGJYaXNTNlB3NkdRQjk4MkhVWmpvN2VvanlnVC9iSys3UW1oRmpxUk9vTHNM?=
 =?utf-8?B?M1ptYzloQ3JnNDVweXZBenNsbG1nZ0FSdDI2TlEvZDFjWnFFYmVzRHJzak9X?=
 =?utf-8?B?b0RZZCtaejROR3pTd1pFRXVWY2VSQ0VhczRyNkZ2ZXVwVWZUcVVNUkYyUlZn?=
 =?utf-8?B?UjR6ZU5tQnpnRmRwVDJqY2daRnpOemFzTWZDYlcxYVByMVpxdDVaT2VrRzl4?=
 =?utf-8?B?ZEJYN2FERkZRaFhSSk1hanpiY2hwUmxidkxCYm9VMkR0QTd0blMzeTRCY3ZC?=
 =?utf-8?B?c3g2RFJBOTZPUjN6ZVN5RFlsSWIySDlsb1RwR0Vjb1RRZllncFprSkNXQ2dw?=
 =?utf-8?B?bDFXa0VmaCs1cU02RDUxSm9JT0o3c01qMUtHVUNzRzkxTnlHQXdEZW9jczJV?=
 =?utf-8?B?bkx0bzdYRlg5aTdDc2ZNZjhiT2E3NFZhR0FVLzBiNmlBalVnVnRXd0UvYzlp?=
 =?utf-8?B?STdsNG5ZRzAyemNiS1dpcDl2Y3hyUXQ0cW54UnVleHNheWtsSVU5YWluQUsv?=
 =?utf-8?B?Sjd5TWhCSUFEZWFnU3dEMFdJdkVPdktIS1U1V2RxUVJtVWtrRmFVZmI5SWQy?=
 =?utf-8?B?L2RSNEJZM3RKOHVSOGN3M3FNZVBMNHBqQjJzdEpCb2Z5ZXVFM0dQTXlSK0lw?=
 =?utf-8?B?YjEvVXNJd01ESmVzMWlGR1lESFk2V282L0pqT2JWL0ZnOWxxVi9sM3Ywc2or?=
 =?utf-8?B?eHk3Vk1pelRtQzdKVDZBVHV5T0hZYjZaOUJpWGdrVnFhVmhsMDcwZ1pyVTAz?=
 =?utf-8?B?dWxwSnNvV3NuMmNNQkM1Wm9Cc1AyMFgvRVp3N2huQjJUN1NMNExUVkNvNGI2?=
 =?utf-8?B?UEJhVyszd3ozakV5b1VweDlqcEQ2TGNzOURneFY1ZE5aUGpMaW1DNklQWlVE?=
 =?utf-8?B?dXF3VWU3d0dxbzdpYncxaktoU003QlVtUm9zK2VwSzlvd2NHL01kOWswUDYw?=
 =?utf-8?B?ZHRsVDAxTzlCTDNSWTVvSHJIakxKcW5ObkU3Y0xUVEwwc212ejQzTUNUYno3?=
 =?utf-8?B?WW9tUms0VEI2cmxjZ05NSWhPRjQwMWUvdUlFTW51a1ltYk9sODh1UXpBR3NE?=
 =?utf-8?B?SThlTTVPTGt1TlJCTWNheitsZThmOGowYUNNM3dRaGFiRUpiT1lnWktSOHJs?=
 =?utf-8?B?ZG1PZVV1OVZUb1RxdG84cWxQUFpSZHNaNjBiU3NQK05McG4yTGR4bDNPbFhn?=
 =?utf-8?B?dU5VaTgrUlpMSHdMRzdyb0N2TlZSM3NpRnptR09jc3YzcWZ0K003V2xaUmdD?=
 =?utf-8?B?MDN3aCtWaEhlNzIxMVg3MDc4NEo1cTBPaXgzakt6ejdqYVd3eWFIZVQ2OUdt?=
 =?utf-8?B?dDVtMkJMeHRFVjVGdkNFYWg4N1d3VXVhdWplU3NWNUtmZkswSjJCR3A1V1cy?=
 =?utf-8?B?ZlhQWEZuWEN3U3c3QlQ1UUJwQ0ZBL3BXbUdRai9KMDZRKzJmb25tQnczbmV2?=
 =?utf-8?Q?/0kJMzOOeXAp0y4wkzty1RonyvfUesPzIb0APrcbiumTa?=
X-MS-Exchange-AntiSpam-MessageData-1: +JLoAZcLRJ00kw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66808cac-863f-4d91-d9c1-08deedf57d9a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:46:16.5199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bEj5sG6uPcHIJUTB5OqKwl5YpQA51uYxOBXyUtloJq0FQoqc98kFrvVGOKWU+Ng/9s8+spADnftaojk/aBtzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

Syncpoint fences are backed by a hardware syncpoint / threshold, which
various hardware is capable of waiting for directly without CPU
intervention. Add a function to allow drivers for such devices to
extract the details to allow programming the hardware accordingly.

The function also provides the host1x instance corresponding to the
syncpoint since a system may contain multiple instances of host1x with
separate sets of syncpoints.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/fence.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/host1x.h     |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/drivers/gpu/host1x/fence.c b/drivers/gpu/host1x/fence.c
index b9a7d0bf91f8..1acf579c562b 100644
--- a/drivers/gpu/host1x/fence.c
+++ b/drivers/gpu/host1x/fence.c
@@ -152,3 +152,46 @@ void host1x_fence_cancel(struct dma_fence *f)
 	flush_delayed_work(&sf->timeout_work);
 }
 EXPORT_SYMBOL(host1x_fence_cancel);
+
+/**
+ * host1x_fence_extract() - extract underlying syncpoint/threshold from fence
+ * @fence: fence to extract information from
+ * @host1x: out pointer for host1x instance corresponding to the syncpoint
+ * @id: out pointer for the syncpoint ID the fence pends on
+ * @threshold: out pointer for the syncpoint value the fence pends on
+ *
+ * Extracts underlying host1x hardware related information from a host1x
+ * syncpoint fence. This information can be used by devices that have direct
+ * access to host1x syncpoints to wait the fence in hardware without CPU
+ * interaction.
+ *
+ * A system might have multiple instances of host1x with separate sets of
+ * syncpoints. Callers must ensure any hardware that is programmed is accessing
+ * the correct set of syncpoints as identified by @host1x.
+ *
+ * Note that a fence that has already signalled may no longer be identifiable as
+ * a syncpoint fence, as the dma_fence framework can detach fence ops on
+ * signalled fences.
+ *
+ * Returns 0 on success, or -EINVAL if @fence is not a syncpoint fence.
+ */
+int host1x_fence_extract(struct dma_fence *fence, struct host1x **host1x,
+			 u32 *id, u32 *threshold)
+{
+	struct host1x_syncpt_fence *f;
+
+	if (rcu_access_pointer(fence->ops) != &host1x_syncpt_fence_ops)
+		return -EINVAL;
+
+	f = to_host1x_fence(fence);
+
+	if (host1x)
+		*host1x = f->sp->host;
+	if (id)
+		*id = f->sp->id;
+	if (threshold)
+		*threshold = f->threshold;
+
+	return 0;
+}
+EXPORT_SYMBOL(host1x_fence_extract);
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index a7a675783136..1221acf83942 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -237,6 +237,8 @@ void host1x_syncpt_release_vblank_reservation(struct host1x_client *client,
 struct dma_fence *host1x_fence_create(struct host1x_syncpt *sp, u32 threshold,
 				      bool timeout);
 void host1x_fence_cancel(struct dma_fence *fence);
+int host1x_fence_extract(struct dma_fence *fence, struct host1x **host1x,
+			 u32 *id, u32 *threshold);
 
 /*
  * host1x channel

-- 
2.53.0

