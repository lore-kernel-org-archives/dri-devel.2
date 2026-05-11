Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16CACD3427
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 04:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 621E410E473;
	Mon, 11 May 2026 04:26:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="v1HxVhUg";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C6110E473
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 04:26:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDl5nbaR53xsfSn1EEWPjIe8PWPIBAZZwVHrv85hoDqPAokeiIopX3pTWHoq3Y0aoorzTXnEznXWlswQtBZQx22WFg/ovaIYIJXlz32ah+/EugsB4nJMHfjDhHSKNGDOznEyiz8Hq0JgZM2vq/KZyKi8SKgghVUwOF75Wn3KrK8ikyZ105g6DA6XQWLUuUrQHflBu5Ko5LIwx8Jm/C4IWgSEQVygET1j5g4ExoiyuPCukrWRoehIB+Lpv6rhfX7rL9TFpQPrSu5ZkyRmXdnt/A+vbdOYOtL8mO2aKA06neG4e0DlHU3zWyFPiWSxT5rj0SCgCDLMmCkVGg4NUNtMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/bhi27CMfz7tzxQ9WQnpa6Cab3DmzlyaO8DLWQcdCk=;
 b=Vrbjcq1tYUVV4Ntttpd2dWJy1ermQNOkDKODVdVUGyybSXdn03TaTAy0ZaYcI/lZh0chfkEIDP0F/z7xNa55EraRhKJHHtfFn1u0/0z8Fkeedq8QWncZzXiS0JFV5o9OQ8lt59k2EcWq6UGCWH68H6nTpsgd0O3VbD2+YT7hIyPHULuQlRBmuRwoO5ay6tjVcv7gpWjG35FpOPxTBoDiraewMJUzRgRMGdegBVX9z8RtSTpgEkUPx5LcfPx4L5/KquRvcGh1R0vWSHPiZ9Txh+gHNANo6nL77Irajq36Nat5NurzWeYMbJRN6ixRTB00BCtB+m33yhV3ALOzIPpRQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/bhi27CMfz7tzxQ9WQnpa6Cab3DmzlyaO8DLWQcdCk=;
 b=v1HxVhUgisd6puTNrsOJdDMHVwqRmJLrR4XRJWUBaSYej2R5K+OLC2aD0ZafdG4oKdmwOvGVzPS9hGIAJevbH6pcLkIWt8N6OMISEPxhM9RhRYlyk5yIAXGf2BGXtSU+A/fLEryt8A36YdaACcvDWHc0+0obdVHs63pszN8CYKs=
Received: from BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11)
 by DM3PPF8B2A18C0F.namprd10.prod.outlook.com (2603:10b6:f:fc00::c34)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 04:26:49 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::8b) by BL1PR13CA0006.outlook.office365.com
 (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.14 via Frontend Transport; Mon, 11
 May 2026 04:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 04:26:48 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 10 May
 2026 23:26:48 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 10 May
 2026 23:26:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sun, 10 May 2026 23:26:47 -0500
Received: from [10.249.34.215] ([10.249.34.215])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64B4QlJA2905173;
 Sun, 10 May 2026 23:26:47 -0500
Message-ID: <e1e88498-8734-41b9-b565-a7477d3385c0@ti.com>
Date: Sun, 10 May 2026 23:26:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/bridge: ite-it66121: Convert to DRM HDMI Audio
 Helper
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: "ple@baylibre.com" <ple@baylibre.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "andrzej.hajda@intel.com"
 <andrzej.hajda@intel.com>, "rfoss@kernel.org" <rfoss@kernel.org>,
 "Laurent.pinchart@ideasonboard.com" <Laurent.pinchart@ideasonboard.com>,
 "jonas@kwiboo.se" <jonas@kwiboo.se>, "jernej.skrabec@gmail.com"
 <jernej.skrabec@gmail.com>, "Thakkar, Devarsh" <devarsht@ti.com>, "Jain,
 Swamil" <s-jain1@ti.com>, "SAHU, JEEVAN KUMAR" <j-sahu@ti.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260318154636.3230454-1-sen@ti.com>
 <kbv3s76q3i4aal7jp5cbjlgned34lztxo3irqxf65mw5pwm2jy@kc362d22y5pu>
Content-Language: en-US
From: "Wang, Sen" <sen@ti.com>
In-Reply-To: <kbv3s76q3i4aal7jp5cbjlgned34lztxo3irqxf65mw5pwm2jy@kc362d22y5pu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DM3PPF8B2A18C0F:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d116cc0-bf72-44ba-da4e-08deaf1584ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zqTMwUIwvkiBB8bASLa8W00pgBEHROfDo+WCP4bYYvFqlV+/B/HQhRxuzKI4p1UP4uaSItdWLnGaPPPnkpxA6tmfRKcE0awchXO8I72tse+4sjtGdCsVvzhQqn98OvD6eRtW3vMdBY1O54rDUgebZDeWqsKPD3mx1/O5efcDcAb0G27lkrhnzrVtlI3USZJ9VqlteZkRfvIUDtjzqr5u+s7t7A/PO2A4xeDIIYuoWmtv972sAVjO+E4e5YJQThwC+nk3j5czt1c4qtWVDJSfXZW9mjMYCDBThUUCuBvptKrzOtfxRgx1EzOR9AG+UBfzrbIxfSsd6fn62SNufTPfoJL0+/1h5J+kq3UyHUt+wQSVEYvNym9i25qbiUG5Nt/Nhyah57NTA9ZVIQudWOhzjLVB1bHeE7MfS08SH/RIErabKGaPqYFgtMcs84PQXeqYpy9eOoUTpxsiFkJfTE5Uvc+LhruopNJiSbVz1EjYLaekqG1pC5IvSUUZW3/aE+ExtNpYgd5oJKTwjcndgwQDdDTsWRy5b+thwfXNzznuyLCuQy/hPAHHkiZtvG4TPYe6e0cCp3vm2wo3bZDSQ4pdj+aGHpn192rVSS8K9GoPutMnhKe2lcRBNpQWKJhGJ247I4dPNd4nmiu/6ZT/e1zfOXzP9IAaXncdAHlCKaENjfe03ydmiZU9fw4KuHkNI+nzX57I+T+J4xWlQwo6payzaF5L8FWui3m2BghFvBAoUEg=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eJTo2m80tmOr75MW8ebDZTO3L/NtpoIeBwiBSIa2IVfXwN+E7b7QfQt1wultOxD3JUfNNBsZyijM4pgscU/jW2uI/64oVB8JQ0s1oOMj0f7iRyY79WpGw3/q5irW37ceJSSdZ51fZOc1KGgAROmVOuO3/lD30lQmK1A6hK66UWwUXvDVkECI/gOyZQ5mMv532q3BNbBWQN4HkvB8M1gLIQ6Xwp1fh1nqcYJraM1Pk4cwdybvL8pV984JcOCGWI7eXY/QlkY3Xge0VdDykNuLJFeLxGUfTaI2BD758XeyfYKWc5Y2dfeWiAg/YjWbbls6MAYQOUsbpx3kDfQRpZguCzDzMqOARDw7kSrMJ9+w7LcHrnNAeVzLnVC0db0JTEG1aCP7d5PfrecLryOVKHMUDgwuwwpH+yOol16U0sIX4Fx3dWxX4lRLO5L0pZHFB7Ba
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 04:26:48.7072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d116cc0-bf72-44ba-da4e-08deaf1584ac
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF8B2A18C0F
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

On 5/8/2026 6:58 AM, Dmitry Baryshkov wrote:
> On Wed, Mar 18, 2026 at 10:46:36AM -0500, Sen Wang wrote:
>> Convert the IT66121 HDMI bridge driver from manually registering an
>> hdmi-codec platform device to using the DRM HDMI Audio Helper framework
>> via DRM_BRIDGE_OP_HDMI_AUDIO instead.
>>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> Also, if you have HW documentation for the bridge, would you consider
> implementing infoframes support? As another followup, would you consider
> switching the driver to drm_hdmi_acr_get_n_cts()?
> 

Hi Dmitry, thanks for the review and suggestions!

I need to double-check if I have the VSI spec, but I can certainly give 
it a try, looks like both AVI and n_cts can receive some refactoring 
help like you mentioned. I'll send out separate patch(s) if it pans out.

Best,
Sen Wang
