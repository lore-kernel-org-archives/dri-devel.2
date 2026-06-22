Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B549DCDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D1310E52D;
	Mon, 22 Jun 2026 08:23:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="l650I2tb";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010010.outbound.protection.outlook.com
 [40.93.198.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1735710E53D
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHICkxB7FgptjjtXQzRqH8Fgfw44p/N/vGN1oqUWNae8huNkepPHl9UbJamb6pz1XVr1+7kZU5s8osxn6DL4QScwRSoMIRAHCJVJ4+ZG2XsdaeQobjTp8wSTrX2DxaHqcA8n1ZDAYoTVqSrYAggukJo1yO/EsUBdXB+XxEKe+8rAPjc59edIa9JFIypdDoAZHLygcEbBMJUVEqZeMtcywbVPhKNjdkCzJiXLJYC8359I3Yp6Z16aHxGO1SmV4hbwF2iLHbCkQTT0X2s9XUM6fOQgV71SCT9rYLMiIpxIulIyGv2YtNx3e4cjs1yiiabjoKEv6LI2ZdoHllIXIX/OKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+u3Nvf/0Xx6qXsKgYyeMjWVAkktSVyNL0+tyZyimBw0=;
 b=pvUQ3d1xcwsa4VdQ9ihhBzY+ApO/YT26Uv/kOt+ovi4bfKpAVTQ9fQbx79k777OisdFb4VhlquswJmP4dBLyFmD3M8f62I/i0e+jqhRX/IbzJjUV9V1siE0inlAYX+1ZW/Mgaiz1EdRbvDvKN4zdgAbcmKjTPEn8n9/fih03YioNbqyc0gvkP0SGuHUc+TLmrwwFubE0yPRbPzjjb5Za2VuweDyJp+GTllU+sKOv9FO8H8jVudgQ8W0DPw44cYMMt5dUBRsDmu+WXVUmEhmRAcf+borc7NiQfb22o0s2r/g/fO0OF0FmJKEyHvvRHSk4Vw3j7w0o5BeOb3SQIUaxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+u3Nvf/0Xx6qXsKgYyeMjWVAkktSVyNL0+tyZyimBw0=;
 b=l650I2tbuK+LDJwyeHuJ+JxjhbySBOGdA56XBDipQbI/47L3595rZyvlcVO1AVxjbJTJxqIMMnjAmZmbjA16UfCP1XQjy3awJvho5aYlYrSHAyHq+sDDUPeD4uq6jdxMvZSu0H1FkNLDhpjdRJMEuLKza82NUiFvzQ8K+HRjiilzcRX3wfqak/8nOZEy+gZF6cy2RpCIz6z8LeHjDXpdod5t0d/kuljAK6l4kLdndLhKrzbzawuCiv4i1RxnyUcaNzUuHEp8ZVQSVqM2wqIClEb22KY2nw44VPk3Av0fVUWcKE1ok89nvVurYGAnvGFVPeTTDpKo9IbzX+Svj4SAyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::623) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 08:23:14 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 08:23:14 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 22 Jun 2026 17:22:53 +0900
Subject: [PATCH 4/4] gpu: host1x: Allow limiting usable channel and
 syncpoint ranges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-host1x-nohv-v1-4-65bc682a617f@nvidia.com>
References: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
In-Reply-To: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS0PR01CA0118.jpnprd01.prod.outlook.com
 (2603:1096:604:9b::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: c3de006b-1991-41ee-64cc-08ded0378116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|10070799003|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Xmb3ZjpsjT5zU37X6csXVklzDbUruGRNrhEDjOPcfdRJ9vqOqJSCnk1MaoD12OhIgyNn1M5CUKZt+KST9Dsrukl2W3G6rDq4XDKAlivPEIf09yMpw/kLoYOtrtmOnxzLApchmGft/P8aHQ7pKNTBP8n6HD9CGLIuaKk/QoH06mOswiuCPqiHug8MQOv8i9IFTBW6lAyDZb9iAIsn9SbocMp4/xBXBF1DdItElb25/Yb2VX0l6AR+PJcD0+/fUCgWhDf3zxYmX2wWRnXh3Z81rectjXMKErd6Z01FXP3P1lJzmA+bs+R/d/fUQamATk5C7lHw09DbQj+d2hsTBkaEfhVhaQ0TjyNIpcGQDxHocg+BpWML9sOse3fbLMsP9WHQElEqObZ1Eubn8boG1bVgtNaWpU5jlojj6Tl6Ssg4EssaqdgkXdzCbNfnCloDAfLU06+qg8YZsmtvLDx7IY5nA3S/gHFZ7MFS/BGAlVlofjIXcZL8VAlTbto9jqMPeBf4j6GpF6VffalVvdTqcYJdWeoQkx8Rz5w5q/vTiyw4tvjEdt+EoT+2ZObIfo4Gd7F0hA3OXfvVCF4YaEb34qtWM6zH6L+WAbNuNuJ9w6rowoF2AJDWZM2v61VLcN7vlh2CwZWBRQREXd1j97xPB4thD9/IIFbqRBS0PFgm3phQCgoUmqbPraPjMUiiBrScRuJghtUt/bEs0f7VzyzFBQUDBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10070799003)(921020)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzQzN05zcDBIRTVxdXhwVTNqeVZFcmEzekRiL01iMTRrU3lrQlJ6NnRISTNR?=
 =?utf-8?B?d1RydGhINytkVVBhMEhzdzArRFBzVHoxK2xWN1NFNzRjazhIbEhnRlZ0aFJY?=
 =?utf-8?B?RDZQdlBkdlRJRFlzREdWYlJKOTEzOGlmN3BzZUVYWm8xYTJuOFRlWjdwREtw?=
 =?utf-8?B?VytmeTV5djVWeGdZM0RPMmtnQVQ4TGhRa3NqRWJDWVRCeHo0YWtxLzBQK0Zl?=
 =?utf-8?B?K1hTaXRwdzNqL005U2NXMDYrNndtY1JwNDJBWFNNZEFBTmhYS1VSOG5vQlZ1?=
 =?utf-8?B?YXR2RnAxMnJFYlJCSWlhRWVlQ21XTjBTZG9LdGFOT2lnMXdPcE9UajBKSFd3?=
 =?utf-8?B?VHJBNHNoaFBxTkwrQUVmNXd3cXBvbVBOZmRCcmFUZUk3K1pPSWFNaEUvd2xZ?=
 =?utf-8?B?T05pdkxmL2daOVRnQUhub3dibkFUY09wc2pwVEpOQzZvK3VkUkNLemNZejNQ?=
 =?utf-8?B?WXlMcXkrcjJ2eUtQUithRFk2N2lNZiswOUZqcHdYeXl1S0haMTBGK08xdHZV?=
 =?utf-8?B?WFB3aU53REVpMHpiMXEvakk4dGxQZW4xRExzRGkzaGFNaVVCLy9WOHN0Znpy?=
 =?utf-8?B?MHZYRlpYWjU4dWZab3BQaXVJZTArcUtNWDNOSVh2Q0dYSS8yRHU2K2NXSSt2?=
 =?utf-8?B?SHNzR2phbTFpc3hEMUxTRU9GT1BIWG4vWC9uWEdGdGFKdVlPbkRvQmRKL1RI?=
 =?utf-8?B?azNVTG95cUd2TWc4QmpBSVJmd21GSVZKY2xhcXZUdGVtd3dOZ0R4eEdNbU9t?=
 =?utf-8?B?RVlMS25DOFhBNEVocUVHS3pnSUh5T3RKa0xUdHY5Sk9Xd1hHT2FLWWdmYWNU?=
 =?utf-8?B?aEw3N1VvWk5qMGh4dEJIazV2WnhlQlZ6WFZpWlBONFBYVTJ0YnF5Yk15OXJ1?=
 =?utf-8?B?M1o4U3pZSjhqc1M1YU8yVFQ1NzhYNXpFSkZyamYyTWdpc0FYek5CclNOT1B5?=
 =?utf-8?B?aHl3cTVQMklrK3cyOThueXR0SG51WkdZM2N0RDVqRzhjK1V6Rmhkd2N0UWZa?=
 =?utf-8?B?SlIxQ1VGV3QvV2psZHZiNGhQUy9RcGhobjFBWkQvREc4bFhvek9YRndqenVw?=
 =?utf-8?B?USsxY1A2Rkk4MEU5WUF0SFRYdGdpa2tnUlM0eVJVZ1BnMm9LS2R1ZFYwSmxJ?=
 =?utf-8?B?ZS85QnpoV2FxcXhpb2UwcVFkS1VBQWM5UE1seXNVSXhDcVpsUjdQYlVhRlBJ?=
 =?utf-8?B?NkR3TU5UbWQ5OUI1T1U5Rmg1ZTc2dHpEZGljRDBrcXZjbWU1NzZTWVZ0eEQx?=
 =?utf-8?B?cnNJbEdRNHNFRzFTR1RXMjE1OGdNNVQ5Z29QbjdwSUVGeTkyM1VsdUtYMFM1?=
 =?utf-8?B?OUdqRUtmWU9QRlF6NmcrRlVRcGc2SGlqZmo5dG1mK05nQlJtc0N2czF5OGVl?=
 =?utf-8?B?dkxLbXNjTWlENGRQZURJTU5KWkdEMG1zSlJlSGdBSU1tLzkyWjhLZDAzV3h5?=
 =?utf-8?B?YVEvK0pBWWpqMWhJRDZsczY5RHVVcU83Z3NKcUdCbzZaSmV5eHE1S2oyR3VU?=
 =?utf-8?B?S0xHTitUemozc0h0UnBTaXg4SE9HclVNZjZpaTQ2MXM0Tk1UYmZjeWZkbVN5?=
 =?utf-8?B?QnhHNEFpNTV1Y1BpZ2JPemZacmZJVnVUaWpJOXJTajYwZG93OE5Bc1BtVkpD?=
 =?utf-8?B?bjNZRlRLK0c5RmRTdWQ3SmxRbGJCdTZPTUg2MHlvKzFuaHQvZzBURDRZazQy?=
 =?utf-8?B?L0J2U3BRLzE0UVVqb2pPOXY0R1RIekQxbFJUU29Xc3ZUZk1ZSy9tRGkvTUxI?=
 =?utf-8?B?ZnVkMnc3M0MzTGFaRWdtb1RmV3hIU2hEU0hDN1NNbTlFV0FVbHdNL1ZoS3Ji?=
 =?utf-8?B?YS9nWklUYitpQmw1cThQSEpldys1akZUbEZWTTRQME00T2hhYnRUQkZqMUhN?=
 =?utf-8?B?Rk52WVNnbkNIeWNMbDJhMXEwVEZKUlhNTkxLNnk4RTZqU0hSblhFODlpTGVF?=
 =?utf-8?B?azlTdzczTndkZzRhY2F6Z25sNGg4bEZ0UlRzZW9KcFd3V1JsVnlTbVowME9V?=
 =?utf-8?B?M2FxVmRycVo1ZzA4M1BpNXJKV1ZNM1duUHBnL1lYaUltQXp5WGFCOTBrVFRr?=
 =?utf-8?B?bWRJYlJqSE40WGJIUlJBR29zYU9IUVh5NlpQU0RjQVdLcDdiZEpFK0hLSlpL?=
 =?utf-8?B?WEk3RFh2UVQzcTlaMTBUVnVUdFUrNUpRTXhxbTIxSWIwU1Q5NTV3QVEvR0F5?=
 =?utf-8?B?TDA0eTdVTFJWT0gzK2JHVXpua2FZcko0S0QrYnY3TmRUd2IxQ3hFdmhSTkpJ?=
 =?utf-8?B?aFlCVXFQMTlFVnZvSyttWUNSVWRVbkdLWm13NDd4dDFrSkJDZWhJdGhIY3RS?=
 =?utf-8?B?dnJrWFluYURNb0lxemNJZlZlWHBQNkFHbVlvdzFablJHUmRyR1QycVlvSWo2?=
 =?utf-8?Q?/Viipar4IJhCnd3+m6RwMP4pTrN49Xz8IO3Kfaqs8ZgdZ?=
X-MS-Exchange-AntiSpam-MessageData-1: umwDeAzyA7f1Dg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3de006b-1991-41ee-64cc-08ded0378116
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:23:14.2642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wa2XtFWZviC9js3LY8hJjS0A0LV9MwkQPeOe7By9tp8Q4t39ElJI4gC8vvl4sJZSDwDnuQpJ7EhkDo+JnQkaCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1
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

Allow specifying usable channel, and allocatable syncpoint ranges
through the device tree. This is necessary when Host1x resources
are shared between multiple operating systems or independent hardware
units and Linux has limited access to them.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/channel.c |  6 +++---
 drivers/gpu/host1x/dev.c     | 37 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/host1x/dev.h     |  3 +++
 drivers/gpu/host1x/syncpt.c  | 21 +++++++++++++--------
 4 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/host1x/channel.c b/drivers/gpu/host1x/channel.c
index ca5d0f51cf7d..38fcdda8388a 100644
--- a/drivers/gpu/host1x/channel.c
+++ b/drivers/gpu/host1x/channel.c
@@ -121,13 +121,13 @@ EXPORT_SYMBOL(host1x_channel_put);
 static struct host1x_channel *acquire_unused_channel(struct host1x *host)
 {
 	struct host1x_channel_list *chlist = &host->channel_list;
-	unsigned int max_channels = host->info->nb_channels;
 	unsigned int index;
 
 	mutex_lock(&chlist->lock);
 
-	index = find_first_zero_bit(chlist->allocated_channels, max_channels);
-	if (index >= max_channels) {
+	index = find_next_zero_bit(chlist->allocated_channels,
+				   host->channel_end, host->channel_base);
+	if (index >= host->channel_end) {
 		mutex_unlock(&chlist->lock);
 		dev_err(host->dev, "failed to find free channel\n");
 		return NULL;
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 545fa2e3f180..7103f018cb1b 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -331,6 +331,39 @@ static void host1x_setup_virtualization_tables(struct host1x *host)
 	}
 }
 
+static int host1x_get_assigned_resources(struct host1x *host)
+{
+	struct device_node *np = host->dev->of_node;
+	u32 vals[2];
+	int err;
+
+	err = of_property_read_u32_array(np, "nvidia,channels", vals, 2);
+	if (err == 0) {
+		host->channel_base = vals[0];
+		host->channel_end = vals[0] + vals[1];
+	} else if (err == -EINVAL) {
+		host->channel_base = 0;
+		host->channel_end = host->info->nb_channels;
+	} else {
+		dev_err(host->dev, "invalid nvidia,channels property: %d\n", err);
+		return err;
+	}
+
+	err = of_property_read_u32_array(np, "nvidia,syncpoints", vals, 2);
+	if (err == 0) {
+		host->syncpt_base = vals[0];
+		host->syncpt_end = vals[0] + vals[1];
+	} else if (err == -EINVAL) {
+		host->syncpt_base = 0;
+		host->syncpt_end = host->info->nb_pts;
+	} else {
+		dev_err(host->dev, "invalid nvidia,syncpoints property: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
 static bool host1x_wants_iommu(struct host1x *host1x)
 {
 	/* Our IOMMU usage policy doesn't currently play well with GART */
@@ -602,6 +635,10 @@ static int host1x_probe(struct platform_device *pdev)
 	if (IS_ERR(host->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "failed to get clock\n");
 
+	err = host1x_get_assigned_resources(host);
+	if (err)
+		return err;
+
 	err = host1x_get_resets(host);
 	if (err)
 		return err;
diff --git a/drivers/gpu/host1x/dev.h b/drivers/gpu/host1x/dev.h
index ef44618ed88a..89f1fc838a1c 100644
--- a/drivers/gpu/host1x/dev.h
+++ b/drivers/gpu/host1x/dev.h
@@ -141,6 +141,9 @@ struct host1x {
 	struct reset_control_bulk_data resets[2];
 	unsigned int nresets;
 
+	unsigned int syncpt_base, syncpt_end;
+	unsigned int channel_base, channel_end;
+
 	struct iommu_group *group;
 	struct iommu_domain *domain;
 	struct iova_domain iova;
diff --git a/drivers/gpu/host1x/syncpt.c b/drivers/gpu/host1x/syncpt.c
index acc7d82e0585..fe27a386cc0c 100644
--- a/drivers/gpu/host1x/syncpt.c
+++ b/drivers/gpu/host1x/syncpt.c
@@ -59,7 +59,7 @@ struct host1x_syncpt *host1x_syncpt_alloc(struct host1x *host,
 					  unsigned long flags,
 					  const char *name)
 {
-	struct host1x_syncpt *sp = host->syncpt;
+	struct host1x_syncpt *sp = host->syncpt + host->syncpt_base;
 	char *full_name;
 	unsigned int i;
 
@@ -68,10 +68,10 @@ struct host1x_syncpt *host1x_syncpt_alloc(struct host1x *host,
 
 	mutex_lock(&host->syncpt_mutex);
 
-	for (i = 0; i < host->info->nb_pts && kref_read(&sp->ref); i++, sp++)
+	for (i = host->syncpt_base; i < host->syncpt_end && kref_read(&sp->ref); i++, sp++)
 		;
 
-	if (i >= host->info->nb_pts)
+	if (i >= host->syncpt_end)
 		goto unlock;
 
 	if (flags & HOST1X_SYNCPT_HAS_BASE) {
@@ -138,7 +138,7 @@ void host1x_syncpt_restore(struct host1x *host)
 	struct host1x_syncpt *sp_base = host->syncpt;
 	unsigned int i;
 
-	for (i = 0; i < host1x_syncpt_nb_pts(host); i++) {
+	for (i = host->syncpt_base; i < host->syncpt_end; i++) {
 		/*
 		 * Unassign syncpt from channels for purposes of Tegra186
 		 * syncpoint protection. This prevents any channel from
@@ -296,6 +296,9 @@ int host1x_syncpt_init(struct host1x *host)
 	for (i = 0; i < host->info->nb_pts; i++) {
 		syncpt[i].id = i;
 		syncpt[i].host = host;
+
+		/* Default to client managed for syncpoints not owned by us */
+		syncpt[i].client_managed = true;
 	}
 
 	for (i = 0; i < host->info->nb_bases; i++)
@@ -305,10 +308,12 @@ int host1x_syncpt_init(struct host1x *host)
 	host->syncpt = syncpt;
 	host->bases = bases;
 
-	/* Allocate sync point to use for clearing waits for expired fences */
-	host->nop_sp = host1x_syncpt_alloc(host, 0, "reserved-nop");
-	if (!host->nop_sp)
-		return -ENOMEM;
+	/* Prevent syncpoint 0 from being allocated by users */
+	if (host->syncpt_base == 0) {
+		host->nop_sp = host1x_syncpt_alloc(host, 0, "reserved-nop");
+		if (!host->nop_sp)
+			return -ENOMEM;
+	}
 
 	if (host->info->reserve_vblank_syncpts) {
 		kref_init(&host->syncpt[26].ref);

-- 
2.53.0

