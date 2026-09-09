Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2298CC79FB8
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B3710EF09;
	Wed,  9 Sep 2026 06:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="XPAxbeSD";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CDEF10E0FE
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 05:15:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPbPaYmgynbxG5DlaswR/GiNGfi1Daxq6g4nnDx8HY6F+hUKXB3tEH479OfGycfeogJrCR8XbQ2mP2jLRnb9kALcR5uVq5zitR4yRDLRa6y7e25IosVkshQzmGSLZEPjFWbURiKl20xAuWdNUGFfuWKT91Ii5o/RJh7V2KZJiCN5+4DnX5LkPvSsLeXMV5KJLFkV05Xhv5xhEGkBnsCslSjfKeX2m+3B9Wt+VcUKbkwU8o6FU9+Pw31VsWJLUHfvNuf2mlKiw3HK3Jm5ovhewUI8TThXA1qZRJyc1dGRzWahCfmdkvi7Hj4wRyQKBSCoK2SZhUZJki+12wDGV1JpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xhw5l7UoJvUA4dP/0V8Rlbg5J9+2xEguVAEq5+5OcE4=;
 b=nhTz+loHr/SSEWCMBB/TRyKVF4Pj5h7iYf+dFEkv1odiUMZvzimCnPdfWl2MHADnwGDDltsXAILHJIrvzp1vX8h2NEYSOfzM6yRczLlvBiEc8ccdbPv3j246RgVQQkrv2A/DKSOq5wAWxxatK6bPDTTClF8SkjuxPTk0BzOPLZ2oBoIe0ovBncBEIGHu0GFyKNgvfMMopuZUCiOgdfNvCMTqf4R39tIdO3H9Hf9VKlkg7mz2ox0cKpX1eZap51XBEneVGGAiidTtsTOawDkHtihzf01Y7kXhlYreby3odKZRdV+dtx0wLKHnx7bhoaEEjFCa9lLMVUhBgeNeuLXeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhw5l7UoJvUA4dP/0V8Rlbg5J9+2xEguVAEq5+5OcE4=;
 b=XPAxbeSD3FyOQnj2pyu6ooqnIK/v/HxL1m/HXMnKfN8VVyzv/LtXa6NmyEyQ6Cu8AQ+INSJ0P5I3pJ16o9hvsnjq1u5AEY2vZWcJDyPre0jOF3UYoqeMsTM8FXG+MU2aoWdqkCMyr0LSHz2dOo1VIeFxkqLtpxKnpslE7xyJn9Umr5A9DP6bQIhvHgdrVZaIiuKMOVheRereDArBqpQHKRvfJrWRsnJ4lZE3Pxr6IU0xDT41NFn/c48HZ8+pdWyul1wttz4ZtpG2xkf+zZcSG6QU/O49mu9mzwahqFOfl51y/p6pJdn1KC94pdHQ7OzdZYNER3gUDEXjbKlFHfIZ3Q==
Received: from MN0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:208:52d::30)
 by IA2PR22MB5563.namprd22.prod.outlook.com (2603:10b6:208:4aa::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 05:15:27 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::25) by MN0PR04CA0009.outlook.office365.com
 (2603:10b6:208:52d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Wed, 9
 Sep 2026 05:15:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not
 signed) header.d=none;dmarc=fail action=quarantine
 header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Wed, 9 Sep 2026 05:15:27 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id BE35EE4DB;
 Wed,  9 Sep 2026 08:15:23 +0300 (EEST)
Date: Wed, 9 Sep 2026 08:15:23 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Gabriel Windlin <gawindlin@gmail.com>
Cc: Peter Senna Tschudin <peter.senna@gmail.com>,
 Martyn Welch <martyn.welch@collabora.co.uk>, Frank Li <Frank.Li@nxp.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] MAINTAINERS: update MEGACHIPS dt-binding path to yaml
Message-ID: <aqDra7p-Wgh0mKIA@zeus>
References: <20260908205203.649957-1-gawindlin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908205203.649957-1-gawindlin@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|IA2PR22MB5563:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d302e3-cac4-461c-d8de-08df0e315c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0r6Q3ipJICtASQFZEREswFX9ETssnjuZ7Z1YHth7DoxHgm5MyFyLgY520YNBC5MSJ/nf+A/Y8znss6xuAvXkCWZdEXq8zQA1MI5VQPaxCYcq/QJSNNyYpOT7Iv5cuqqWOLoDCUQRxup0GIrWP/tG+0ZTSSOmiYopXYP+2DxisNp2CTI4pTbWuWiNbaopeDT/wpak4ig8L9BNxKvx2TKvI3B3wWyjlwc62pAlKPUPIDPFBLqj9UPdIUgbIOJNthcrzKrwOvUdSYc+oS2981AEQg1c9UWNXYo+JyyIc6RV4Y8sFjHP8wKdNk9xA67txKKtKeu5D3j0YxArp36vkSMjUn2cJwZf6kPWthEYNvo0TCNMMX3ICPPyG2RzjNqQ64HNulQMXQMFDzg2l9pp/gmJaKgLODMrSd6OFF/Cu2OB5cxvAIpmWIfeQQF2ytA7AQm+KsffCa/kya/uNxNMlPMGJc7Bt14X2//WUYLKs3UTKA3kjqA7RkiljRNrfengIdCp5jEUlI721v0RdebD44YAYndPM2BnfbvAac97ztSuuiXobrAm3R7T4yrN/thYUwwKfP1qIbPQfeXYwaG1dkXMNTrM7a9iINFJwa73e3bD/niBKHV+Iw8hF6zJ1IwwO8DUfmOMIrUh3nUyKUDuTJRyiuaGwKO64ajPueqJR/asJF2QCU3Lm+6JbY7W6tMZaY0txcS/soCIfwtDbH+fbcX2Lw==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n/N6pVHoDqcaFLGaZnNYDvwOiwsy/uJ/kn8qGN5rW9zEvyfdVA7HxBsNoxs4JfWfNGWKIJjjknBGtmPx5plJIEMmFEfXapXXy81ubR+kwuB5sDULdRG9E4PFm+jERBrg0UPiiNS3tTYnbiojmMPtI+xE48Rafknb0O9meov/EbAlEd76NTLNDCv2Qf5WPx4hCuyUNpK51MGCq0tPjfdH6KfTLsXtWScu1oFuyB4yyyKSwxdf/yZ+ji2v8L1u9vgB5l9SCtT/O+twhjM7F0X8pSYaAB2O+uBaXWALzHWFnyb6w4AsJdmOni/ZFdFMfjcKtXt9HpCXJ0RUwHdaKpwbu/CTXQwC7Ha26bqTPnCktV+zPMk7N273qJJD1eNm0iZlBBveMPygxHJdE4V5R45sd3IhSBbZ8Rxj/RaqqLAY1B9WxjYhhZywrXLqSVuxlGb/
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 05:15:27.0799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d302e3-cac4-461c-d8de-08df0e315c2d
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR22MB5563
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

On Tue, Sep 08, 2026 at 10:52:02PM +0200, Gabriel Windlin wrote:
> Commit 74459b0dacce ("dt-bindings: display: bridge: convert
>         megachips-stdpxxxx-ge-b850v3-fw.txt to yaml") converted the legacy text
> binding to YAML schema and renamed the file, but forgot to update the
> corresponding entry in MAINTAINERS.
> 
> Fix the path to point to the new YAML binding schema.
> 
> Fixes: 74459b0dacce ("dt-bindings: display: bridge: convert megachips-stdpxxxx-ge-b850v3-fw.txt to yaml")
> 
> Signed-off-by: Gabriel Windlin <gawindlin@gmail.com>

Thanks for fixing this.

Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index da3e42d2d190..e830a31525d4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16848,7 +16848,7 @@ M:      Peter Senna Tschudin <peter.senna@gmail.com>
>  M:     Ian Ray <ian.ray@gehealthcare.com>
>  M:     Martyn Welch <martyn.welch@collabora.co.uk>
>  S:     Maintained
> -F:     Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
> +F:  Documentation/devicetree/bindings/display/bridge/megachips,stdp2690-ge-b850v3-fw.yaml
>  F:     drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> 
>  MEGARAID SCSI/SAS DRIVERS
> 
> base-commit: 5acbae5f7eb3d5275120abfe698c394b7325dcec
> --
> 2.55.0
> 
