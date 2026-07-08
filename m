Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D3EC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B7B910F458;
	Thu,  9 Jul 2026 07:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="k+HeT2YN";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022072.outbound.protection.outlook.com [52.101.66.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E38010E57C
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 08:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MA5w7puYR/PRi9tdBLFFFiSlT4rRF6ExFs00SG1rqT5noZq4809LlCVcS90TCo8uqLcon+B0p6sGo9Jtzg0LOPWV2uPy+JlQb0Bvs8ajq+wwmw4UnqPXL8hQhpkTTF1tWOfYQw1D6vKbcsFwdgYY2slcLw+hyBJcwvo5IWoDjF8rOI+7KvdBleYYWIyRGKcoxqY4puDVeqTCM3F+l8PZeNr6VuZeDmz7Xxrx4I49ahU/2faMMQ0VvXPOSU+tAKbDDN4K9C4NcI/Vo+QgYtWKp/7LI6BrcFhqwCNlWV1uhyucoYULVzGyT7WZMoNuSM3oykijdhwCNHqIFzHTLcPUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx2weQRp0GxB/O3RUCClEbQ0YljvrkRs8Xafl9OKNhk=;
 b=PtOiKThn/lu3ijdEjDZUX0uo4liuXqg2oNyWesLTnjaDFd+33vT2AOkuKmeIxN0Al/80osRoAUDSe6JnsyzVa1WlZUTkwpRiX/RPjlrfEhwI58WGW8SmZkttH4nSnCJsUmtor0lEXCrXbXcNAmUS4em8MKwP4+pvEzC9hcyRr1uO1rNEmHA+GL5HY5QJT5lD+Ni31ocBlJgsHSnul0Py5BjFQRMSAxCgLb08hnpp2B58CPH+iH/6EVYR5Lk86QJELw43LIssKPKVCioo/4zpwt9hmRHNmhZJyjDIthvn+DSB9rqOFDResQvsnap9JrSeIBeqL4k9TgHmV2GtA2Wv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 109.94.150.189) smtp.rcpttodomain=ideasonboard.com
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=prodrive-technologies.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx2weQRp0GxB/O3RUCClEbQ0YljvrkRs8Xafl9OKNhk=;
 b=k+HeT2YNg6csv+mN5kBwxxOIzrPqv5HcvCkUJOTGl0TN82ZhvYPl9Ubt6OyjBOtolS2xbkBlaC13Z5O/6xkvX9hiLLa09We9B/4qShMbbPpHhTcgmkfwoBW9LgNG7O6QU/jFquQn4CcYe4rh1bpuK2b+GsmMrKLUiT+Cda4oAq4=
Received: from AS9PR06CA0139.eurprd06.prod.outlook.com (2603:10a6:20b:467::30)
 by AM0PR02MB5841.eurprd02.prod.outlook.com (2603:10a6:208:181::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 08:05:20 +0000
Received: from AMS1EPF00000094.eurprd05.prod.outlook.com
 (2603:10a6:20b:467:cafe::3d) by AS9PR06CA0139.outlook.office365.com
 (2603:10a6:20b:467::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 08:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 109.94.150.189)
 smtp.mailfrom=prodrive-technologies.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=prodrive-technologies.com;
Received-SPF: Pass (protection.outlook.com: domain of
 prodrive-technologies.com designates 109.94.150.189 as permitted sender)
 receiver=protection.outlook.com; client-ip=109.94.150.189;
 helo=webmail.prodrive.nl; pr=C
Received: from webmail.prodrive.nl (109.94.150.189) by
 AMS1EPF00000094.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 08:05:20 +0000
Received: from EXCOP02.bk.prodrive.nl (10.1.0.91) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 8 Jul
 2026 10:05:19 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP02.bk.prodrive.nl (10.1.0.91) with Microsoft SMTP Server id 15.2.2562.43
 via Frontend Transport; Wed, 8 Jul 2026 10:05:19 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
 (envelope-from <paul.geurts@prodrive-technologies.com>)
 id 1whNHT-00G4Pd-0p; Wed, 08 Jul 2026 10:05:19 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <mripard@kernel.org>
CC: <Laurent.pinchart@ideasonboard.com>, <airlied@gmail.com>,
 <andrzej.hajda@intel.com>, <dri-devel@lists.freedesktop.org>,
 <jernej.skrabec@gmail.com>, <jonas@kwiboo.se>,
 <linux-kernel@vger.kernel.org>, <luca.ceresoli@bootlin.com>,
 <maarten.lankhorst@linux.intel.com>, <neil.armstrong@linaro.org>,
 <paul.geurts@prodrive-technologies.com>, <rfoss@kernel.org>,
 <simona@ffwll.ch>, <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/bridge: sn65dsi83: perform host_attach on attach
 instead of probe
Date: Wed, 8 Jul 2026 10:05:19 +0200
Message-ID: <20260708080519.3830195-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260708-fresh-malamute-of-resistance-eeded4@houat>
References: <20260708-fresh-malamute-of-resistance-eeded4@houat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000094:EE_|AM0PR02MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee0b494-df64-44fd-0bec-08dedcc7a7ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: EcpEcAfWDu3V0vycNVYEUMu9DWN/WuYZBfUVenQmz3xRZ53sHGeSGAYEwa0aoVEDJstvjcQLShafTERfd28wkAUaZIqFoOd7mtgZgeNEemIGoKIjN2ONdc0o+rL5nbih2XWQ+I10GKd5jFifyxrRla9m6wdwqEdQTgYASjNvH8Ov1Fw2b3BFKQ4uRskldUkAZV/bVavnfPSFwtUnB3BjQ0t5RQJ0S8Ng7w0zkZB4PcbGvKKPve5W8Ljd18mLGid8pq7xqBqMjiAGdqP2BGEs35kBOqTOWMDNJycKrq946zwLYzw/v2Aw8KDhDCUQjIrCXtmlRSUzcgdBQtC1SpEzDCWBcEQ8ikiAWRbRIIfpcAgoiANSyjn9qeCEn3QCX62OhYwXPoLix1YFX9uDp7GFT9H5KwkpJTihe3+z6ZPT3S2e7kF4B20RkooojZbH47JyGw7/QewaT/RhOdDn+7jQRDmwMDc26pfhuwzCyIKMg1iS+bT8LJ/re9dPLGJAZkxS2J57MaF46//iTE+6P/kDpqs6UPAX8JfRH68x214BAkd+4TMcNrteoRHgiIjdAr+1w1+wqtCQ0c1eqn6ShotvI6PGZLjigY/CdYHWwLUJGnnTs8RMPUothrij7pmgzmdO5RwKgKjAHRoorEyRbhqD8haeQUUGr3ibSKrzzytAAk11LRwOTnIb1b1JHLoNqgPOZOOpHRP9HDLQWj1pmH/Yag==
X-Forefront-Antispam-Report: CIP:109.94.150.189; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:webmail.prodrive.nl; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2kkNEZg2Z7aAQpnrmNDTmjHagcKMIdcbSgP5IDuu6BIOfzlW13FfpueqSrD1dK5veQGLvxIQvy4HCoHjkDtI/b4nTsKjxfhOibvHrLOZsdGr91PRtlRzMk+oliaWeMdoe2ki9ls6V0vVrcvKxm58c0qDVmu5OOK0thvPxlYM2jBKlQL0TU5FaojsUkUXrMGfOGWxf1FCjKidwCqtwQFT7Sp5HNcNBmkgQa+TtACV2IonLsCZ8g+KMz0z+N+NRDhKh/uZSBTIxt24fTlbYojjasGI83jgv2u9qkJMvqfE+Rt+w0WLr8TEGApr31x96E4MUGbRduzei6nEUVSmB6ovaTKfO9/hBun2KZgkC/zoL34JepC1QOJar6wLkHNmvELYAJmYzmgt3WpLb+ZkCX5HkUk8jDyqRrEwBDM7QPjitJ5LlW8n5tGmOb8BC321yRn0
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 08:05:20.6706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee0b494-df64-44fd-0bec-08dedcc7a7ea
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=612607c9-5af7-4e7f-8976-faf1ae77be60; Ip=[109.94.150.189];
 Helo=[webmail.prodrive.nl]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000094.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5841
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:20 +0000
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

> Hi,x
>
> On Tue, Jul 07, 2026 at 10:46:55AM +0200, Paul Geurts wrote:
>> When connecting the sn65dsi83 device to the Samsung MIPI DSI host
>> controller found in i.MX8M Mini, probing the host and device
>> infinitely defers, waiting for each other to appear. on probe of the
>> host, it tries to attach to the device, which has not been probed yet.
>> It therefore does not register the host, and defers. When the sn65dsi83
>> probes, it tries to attach to the host, which is not registered as it is
>> deferred, and thereofore it defers as well, without registering. This
>> means the two drivers are infinetely waiting for each other to appear.
>> This is the case on the Samsung MIPI DSI host controller, but might be
>> the case with other host controllers as well.
>> 
>> Only register the sn65dsi83 on probe, and attach to the host later. This
>> means the host has a bridge to attache to in probe. When the host
>> attaches to the bridge, the bridge can attach to the host, breaking the
>> infinite defer.
>> 
>> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
>> Fixes: 6ef7ee48765f ("drm/bridge: sn65dsi83: Register and attach our DSI device at probe")
>
> I think the problem is actually that DSIM doesn't attach the bridge in
> its MIPI-DSI host attach hook, as documented here:
>
> https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html#special-care-with-mipi-dsi-bridges

You are correct. I just wasn't aware of this piece of documentation, and
changed it in the place I thought was the easiest. It should indeed
be fixed in the host driver. I'll do that.

>
> If it doesn't fix the issue either, we should revise the doc further.
>
> Maxime

Thanks!
Paul
