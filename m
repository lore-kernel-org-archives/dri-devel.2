Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1D6CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2191810E4C6;
	Mon, 22 Jun 2026 06:58:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nnwi/D29";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17A710E4C5
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNOnEqPxBK5QhZP86FrfumamCdniUymPa+lvlv5CxtDfQzPLNsU9sbr3IhZR/VDL56POm84HE+VO1s27L+8WTa2qL7MhW6EkMaiQkQLmNFkNtJX0gAEkFQ+R2D34YdeZgksakByPYfyCDW7MtmZfXCT+vAlv3gdWFM3Xqxh9ErPaYGikOW1ltdxYVu+W6aoPwMJkDMavvEm1QVNR9WWfbP9KxWscT9tKrHE3IfWfHtQ2vfLMs1xD0feO3Iis1v7nxRyULzLbFfNl1NVAyd1qEch576GXyiKfzj/KGu6QE0XNuO3FDniTUc6EcQ51dOkaNuvsbOSDmlYqpl/79VePUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/S+7van/3ZkOsP5FR57I11sbOXbrhwhXfOgYssWE00M=;
 b=MV334Mic0xkrotdxR6e9LdpooT4ScmcT3PTsCM75CgZa7GWh83bOTmQjDPjkgS74/XhxIAeHmfDVE6tAJL7Oom3WXR3jPfciVGr45N3b7T4tWfoB1+EWEj075Wu+LQqv2V0EE+PazahHjMf+Qe8nrXZAQykgLuYXA8PiW5JnJclqph4ZmVbNd5A38VajBe0Y+1Q7ICvSNjSRvqKUYGaZnRy0xt3MKhqZCHa+QQyzYI/G0fzENXyRuUYx0efFDe0yh/JdgyoQE9BgYSgcJb1y+eW9b0YCJmgS3+18FlHWxdBQOrAXIVEBoUNSuMH9vF1CSd1CT+wF0oSd4FmHjiv2bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/S+7van/3ZkOsP5FR57I11sbOXbrhwhXfOgYssWE00M=;
 b=Nnwi/D29MRrMk5RYTG5e9yTrzzXS4I5np0OOzqCE4CeicOb577E6tKabXh3jcQEw5Khz1ndlv5Zoee5zSPsIkIpJ9AtVMQGSKYkCXW7YIY8UeJ3uTlkOGklOmfkn09Ga1Qd+wFFvcIKHhA/zBPg/1+FNAP+7fqI3xV/RM0yqPW0OmI1Ui9L7XIP4V1QJXMzieoXDxS/dX2t0Axh+LQT9PHAWGoy6otmmm3j6KypyJfF0pcX2/vwQ2kdSX95ap6SvAY+G+eqcEX0Lj2U0tkAzE8IsAsLEMkSrGS1uvT+QTqAp4X7u0pDnubVomddh4AUoVFmYfcCfoCQ0pUjYOKc5mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 06:58:01 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 06:58:01 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 22 Jun 2026 15:57:39 +0900
Subject: [PATCH v2 2/7] dt-bindings: display: tegra: Add Tegra264
 compatible for VIC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-t264-host1x-v2-2-ff7364d9ff7b@nvidia.com>
References: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
In-Reply-To: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS3PR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:604:dd::19) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c189dce-b8b2-4aae-ae71-08ded02b99cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|23010399003|56012099006|11063799006|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: Jdu+viwR7inAEC9e3ZPiZaTQ4YnKZeatdzCQ/1Zxbw/hY48sFzUzkG2DWjL+3ptyXhNXH1K8sttyulyToratVCXjcmmYE5c14gH7kUIOV0tzgUzvfMyCz8NgSQD5DgMCpOn4W1QbxjJkEOzNPC7YzIgxdiBCb+XCV+BSM/8PV9HTT5ppdNiZeELBo8dLb7zv8pxhAyxtKTyZp9Jqoj5qWjEkewWsGG5OBrA+XggyNS4V601gwPXK3xIYgXU9o+zWhu2U3tSYThyD19K+WjwWwlbNbeBAKzT6eXfsmIbQKyfI5O/EIwaa7gGvGIMJwArltQNnW7DmBkhdZNLKFielCRm7QSOpzhEe3zjOAc060swOx4EVLeO+SToIWnBZ3BuZWvqxbbS/FRBvuHx4f7RVIBL7jk+TELpF3aYbX142XdveObkIhn2IsAS1nczri/WqCpwL71HSmZ+IfvxgobEhtyosoVM+5SdekVujVhW9vDGQBJ0Wxu40ekwMsSTaMy7MJnLG13Tw9ClggpqOel199y1MFKBDdgY7ym8RuiD2fTEZpGzkVB7gUQOONmI2r9P1tHSlAM5mZnxnVm2Ucvn2WI8wCZ4nVA9x7jVwsIvb/yAsgVOpN8OcMSStGs2+MPjKIK7ZjmpIarCf/MF7MZ4U1PHfJRIdTSyyLYQSeB2bT2kHQ+JgOf+mtyZwegJGScJZr1MfPs9MZmMlMhObOq6VuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0s0djM2NkVwTndIY29pZmVTL3hQWmRaRktXL2tIMnJudUFJYVZWakhLYTFQ?=
 =?utf-8?B?Q0lYSGRiVjNnRTFNaVRrQU5wVFlpaVZ4cFp5M2JCbjkwNDNzMHJheFB6am9k?=
 =?utf-8?B?bWtMaUR6ODJieTVHYjIwSUw1cUxidjZsVFZGOVpyOEZFM1ROWkc0YTlNbEJU?=
 =?utf-8?B?K0VNMlFmQWVBY2NJOVFCL2Z1R0JKOHhZNk80bmR2Y054VDk0M1dDVXhiRHFU?=
 =?utf-8?B?M1AvamFQK2x4eXU2YmduVVFvZ0ZsSitEeGErcFJiN2lQNjdPdjVBNDJuZlBI?=
 =?utf-8?B?WTVWb1B4NlRpQVloQ0JmaE9rR2lFUWN0ODhrcVBpdHU1S2lBU0xuMEViN1Fa?=
 =?utf-8?B?OCt1OGNlank4eXJjVlc0V3RtOFhQMTFDc04ycmh0WWl1UVBQN1ZFSW9TWWU4?=
 =?utf-8?B?Y0FnQVM3b3dZcHgwOEMxUGlSNGRnVTdRV3lBRGpOdzJIem1OczNzcGtyWE5L?=
 =?utf-8?B?SG5DNFh6QkFqREhyV2tITVNSbk9YbTNYQ3ZrVFdtVGlQcW9CSEFhOGtubitC?=
 =?utf-8?B?czhFdjlzOCtWTW5xYVlCVDJvbi83V3ExWm4vN2FiU0JQeXVIRzBwN2Z4T2gy?=
 =?utf-8?B?Z004ZzlYWEhZSkhhT1pxbDBpM3AyckFMbHg2MjVTWVZlYkJKeS9CMmhTQ09G?=
 =?utf-8?B?Z0NBVlF6eHdySWZvRTNNdURoU3NEc1NaVFkyZ3ZxcmxQMDQ2SEsrWlA3WCtk?=
 =?utf-8?B?NVoybFpsVkJpVXRtbVJhSmtFVzFRbEUwWGtnUTV4VmJpczNZVlc3bUpHNHJy?=
 =?utf-8?B?UFhTOGg3VjUwck5aak9GTGVrNTN4WlhHRHozb3N0bFlvZmk0amJkWDVCSG1v?=
 =?utf-8?B?Y3hLcDZWenNRRUQzYlBidW5lS0lZQ2xIYXlXNnorcWhPRmY0azZqbk9HcXhz?=
 =?utf-8?B?aW5BMkI3eHF0V2Z3K1VuYUJHSlpZYnlQZDNJaXcrcHVFUlBsbFVQblRMUjZj?=
 =?utf-8?B?ZHdjZjR1UWlISmhTRTAvZ1FpMnFISnNyMVZrZnZvN1Rub1REeis3MGpJekVL?=
 =?utf-8?B?anB4VUdRcGtZN3pHK0hxVXFNRkdNcnJjb0g1c3ozaS9rbWVxWEN0Q2VQaEFx?=
 =?utf-8?B?YW9wYnhGWjAzd3NSeHloSDFtaVB2eGlyU2lrbytQUVlLYUhpSVlINHVDR1Fz?=
 =?utf-8?B?eDhaY21XUjJjaFdxYUU1aDRNcllxZWp2Ny9PZ1dMalNQSGRWYlc0Q0dKSmJD?=
 =?utf-8?B?ei9DdEt3TXUrOWdySUYxRCs4Q3c3RCtLK3FLMTZvY3Fjc0JCVytzNHVabTVt?=
 =?utf-8?B?cCtFMENlM2ZtazBESlczQ2VWOXUzUU5DR2p2cUVvNmV0TDFSRUZVa1lpSkth?=
 =?utf-8?B?dk1HSlUwNkdiWHdjdng3eEtwd0FlWjhyb0VGZVQ1UVJWbmNGb2FVdDE4QUNN?=
 =?utf-8?B?NjhuQXY1a2JMOFJQOFFWYzFFY0pQRjFOMW5pb3JMVm0raHptOVBKOTZtMlUx?=
 =?utf-8?B?eXlheFV5WDFMZ0lWMlI2KzU0OGNmYVZWVTNOb0w2b0t3akF4RHltUEVWMGVF?=
 =?utf-8?B?QklpUzZ6WGFGWENyRXNsZ0QzQ3lIMEJVK0hiNVdUSWFmSkZnVktKM0wwbjJ2?=
 =?utf-8?B?Tnp5bUdqTitpSzRQM0NJRXRTQjBRb29RNXBHVlgxVDkvbVRkT2RESk53d1Zk?=
 =?utf-8?B?WU8rTEx5engzcTJTcU1VOXA1REZ5WWxlSHljb3laanBRbnllZ1FiZ3ZjN0pk?=
 =?utf-8?B?VlZIclFXK3dRWXlaMVVtMG44VmFyZ3YvYjNlRTZ6RkNUWU55elBkU3JSM2hu?=
 =?utf-8?B?VXhYVGZzUHV3My9teTc5REtpdmVPWURuNUNSNDNFUE4yL3RybHhnUU14cjZT?=
 =?utf-8?B?UDAwZlhTZW1heEhqN3pDUDYrTEViVGFzazEwL1BBRVpDN2U0cjJaMjdKZXNH?=
 =?utf-8?B?YW1hdjNVYzRKVWNZbklVMXZxS0JRMnZzR0hYeUpJdmZHY1NFbnFQTDMzRmc3?=
 =?utf-8?B?SW01Tm5xMTEzYVBURnBvU1N6MTN5MSt0YzdSTVhKZWJUOGdOa1BNVlZBL0NK?=
 =?utf-8?B?UnFQMXF2a1Z0QW4vN0ZxZTZ0WlJueVhKOVRMMWwrVzdQY1orR0s5amJqd2dY?=
 =?utf-8?B?cldtYXEwK2xmWVFYVjRKNHY4eEVwL3RnZE40TWNFZ3BTbEY3dEJVamVnTURM?=
 =?utf-8?B?VnM5U0l6aG9BeW9xbTFUbzJvRDN0MDF3OW5TN1BXdFFVeHpIUDZza0MvZ2JU?=
 =?utf-8?B?OUM5dzVuaEJrdEZ0WDdldlFHNkNOZFczVHBHd3dQQ1JsTDduUDBkVjkrdTNh?=
 =?utf-8?B?clRPRWMzWEpRUGtValpQc0JmVTJnS0VMTjhiY2xpdjN6ekN1VXU4MHVuaW5M?=
 =?utf-8?B?SGMzczg5V3FJa1F4dUpMTlZGMk0rcTJPUVM0TU4wSVh1aFUxN0ZNemptcjhj?=
 =?utf-8?Q?o9fxEdVUsEPJ8D319dqUfTt+I4gvAjVbMjvqWAOejFSq0?=
X-MS-Exchange-AntiSpam-MessageData-1: 7GYA6X2wABROmg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c189dce-b8b2-4aae-ae71-08ded02b99cd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:58:01.6707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xA/gNpz/m0Y6odxhEHqepE+B3v67+F6u4NUr1oiCoKgqMTgJ4HT3g4wDunI7hyRtNcT69zk0v1YZJUPRSj0eBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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

Add nvidia,tegra264-vic compatible string for the VIC on Tegra264. VIC
on Tegra264 has a new RISC-V based microcontroller and improved image
processing capabilities.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
index 7200095ef19e..bdf981781bd5 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
@@ -22,6 +22,7 @@ properties:
           - nvidia,tegra186-vic
           - nvidia,tegra194-vic
           - nvidia,tegra234-vic
+          - nvidia,tegra264-vic
 
       - items:
           - const: nvidia,tegra132-vic

-- 
2.53.0

