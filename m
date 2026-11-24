Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AB6606A333
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11ECC10EC2C;
	Tue, 24 Nov 2026 06:17:30 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023095.outbound.protection.outlook.com [52.101.127.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BE310EC2C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDzo75pPBOQVifFr52WvuspjAFBYKZh+IYyjppbs6+DVjg45Y7B6BenQkupjeYHtQybXFWtP5sOLS0azAd9zFfEsNHn11N1bnXYDhHwnNcCMZ91KWJK6p5/dRduXWzZjc+AFkyy4q8taWXlURWvS9uhgIWHQtgIAZ54L2zihq1H1c1BpwN/bqh1C/aGxdERohU8qisEo3NazkuCSDbbwC4/JKUIeCUyiLkzItSvB62yBo2GAHP4spysRoaKOPY2zrVevty6Aah74T5mrW2CahvJPDHmPxm39pjkaB+saBedLpnw/TfDR61oprAjtuI8r/2X0AT7Yn60BBFDoBbb4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC1SwcRnB3qHtnUS6OrmTOLXoja38qTpuQD344gSjAk=;
 b=dIR2zvYFokA51Vu6JdWRNFpvT+8cYdsFP1aztlDIYOIeEPrAjuFzdao5hQYqYsi4+DlWQyONhTRs36GY4JXGz/U3texcYwPzhgGoTkH+tI08a/t75drHEhuAE3M8R7LgTOMzspuEwam+z5PtZLHpOzMK51mbMqKkfzJfFCfKZ5+eh5Lvkbfn4T9MZwrRsJhh+CTyAPpx6rY+Fz51hXRaE+DDEObAJkXaQkZpzKK4S2Rt5KULooi9pMFguUgITjyct3g18Vs3IsG+23Jhd7LZa9gZ0xaGinNdwOZhZElkfpAPyZ+gIGXl2n8gweQgg8DFfVMGRwwKn+skDiSBpHihFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OS7PR01CA0045.jpnprd01.prod.outlook.com (2603:1096:604:257::20)
 by PUZPR06MB6171.apcprd06.prod.outlook.com (2603:1096:301:11e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 06:17:22 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:604:257:cafe::15) by OS7PR01CA0045.outlook.office365.com
 (2603:1096:604:257::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 06:17:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 06:17:22 +0000
Received: from cix (unknown [172.16.64.42])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 30991427EFD7;
 Tue, 24 Nov 2026 14:17:21 +0800 (CST)
Date: Tue, 24 Nov 2026 14:17:20 +0800
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: boris.brezillon@collabora.com, steven.price@arm.com,
 liviu.dudau@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, gary.yang@cixtech.com, fugang.duan@cixtech.com,
 daniel.almeida@collabora.com, aliceryhl@google.com,
 p.zabel@pengutronix.de, daniel@fooishbar.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 robin.wang@cixtech.com
Subject: Re: [PATCH v3 3/7] dt-bindings: gpu: arm,mali-valhall-csf: Add
 system-cache policies
Message-ID: <awUr8JIE8GTgxwL4@cix>
References: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
 <20261119123850.2994625-4-cunyuan.liu@cixtech.com>
 <20261122-greedy-cuddly-hog-06c4ac@quoll>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-greedy-cuddly-hog-06c4ac@quoll>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|PUZPR06MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: b3589386-f308-4dd4-a37c-08df49f299e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|23010399003|36860700016|261009223027099003|6133799003|18002099003|22082099003|3023799007|261028144727099003|261022105027099003|261102123227099003|261026140227099003|261021121427099003|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: Y+leva9Kz6CeEVTixEYppxAgAl6EAsvL/h3l8UlbmR/H+yKOktYkKCdbOK8TDoonWz9VMzhJCP+azL94x2MK5X52UAFg+bCTQ4ioRazhtbwqRQSF/zKzpxhXImEv8kgP3n6MDqgj0B/I6oGTxHY9bQYbsuni34l1ytBiOHpHGiLhmbWiM0LV/yexOw49AEoKpNwWGY/o76nkfU7O9MY+JB48ssdU+hYcR4cstIR6q+saNBWlgdvhYPt1vuV2T2zY/wqecpM1Icjk+U5dHNZxq9Xcl1hubJRmrGN2HvCsS1LQW1brs6LIjiV7HUz4XKc838MbB+CJcAotfqqoGVfgDq92QjY0wukZgRcdAqHjW5xlIYt5Zw7D31/h34YVgwQV6wLEaWHmZkKylMbIkmq7HvAtgTnEHAPE5I5GRMCtYfFUTS3yD39Pmkf23zMMzux6yrevlwS9Le0ctLz7PwDn85MbAdlxO6mDeX+fYeM9OFkm0RYiF4ja8hxNE18IuBcQt5mzOPOoHW++yyb2MIZ+ODN1jjIcOIfnsqqkzPXcVFHJf6T+OiFZOAk5N0xbygat1tUQLMzBMtWpCIKAD+xpYN1Bskx09aV5T6/3hD44FCumXsG0w6ZoVKfft2VPhuRvUnTWlpctMQ8ypyWdKbcwp1id+oGbLQY4aNsy2OiTRSNIc4G9g4Bchb+CD6OOnvMxyR40HYH7h4axMRFm+QZymg==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(23010399003)(36860700016)(261009223027099003)(6133799003)(18002099003)(22082099003)(3023799007)(261028144727099003)(261022105027099003)(261102123227099003)(261026140227099003)(261021121427099003)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IL0Gfrf+Jsz2oDqhODFYXdUSRsoTBXMvreGJrUUVuKju4Zmrz7lwQqtgEE3ERM1upQmhLGn+lYmtc04i7I86TsMr8WgpHM8E4/FHXlqL691MuqQ0m1d3m/zI933LTm/npPv/k0JgGU5ZnRsYZ7FJ8wGwDJRNEOTKNC97V4m/wu9xIzMw0oU9QhJxlpuqJcMiK1Poc1Li9MzbSKcTnq4feN7hNyDs1/1ri1LdqgMx6VpkFumtCfdy+9MxlcjXbUxMUespsnPP42xFEWoh+RogLJU6i5lykG3LOUTC8Dy6zDgTfKdOReyqX3tM1chjAbubr5H53D9WfOjk5TX+hEQyOX19ndYoRP9fYaickeHh/r0rXZbkG60itbtujgy3OK9tZJPgj81NQq4KikfrNdW6gqd2fb8x0OHNlsW47ZCIRzWvpcoQNXlJ/PcxB+lw7A7o
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:17:22.0515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3589386-f308-4dd4-a37c-08df49f299e2
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6171
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

On 2026-11-22 17:58:56 +0100, Krzysztof Kozlowski wrote:
> On Thu, Nov 19, 2026 at 08:38:46PM +0800, Cunyuan Liu wrote:
> > Describe system-cache allocation policies for Mali GPUs with SYSC_ALLOC
> > registers. The policy depends on how the GPU is integrated with the rest
> > of the system and belongs in DT rather than a platform table in the driver.
> 
> Explain why.
> 
> 
> > [...]
> > +  arm,sysc-alloc:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    minItems: 1
> > +    maxItems: 32
> > +    items:
> > +      items:
> > +        - description: GPU internal source ID
> > +          minimum: 0
> > +          maximum: 31
> > +        - description: Read allocation policy
> > +          enum: [0, 2, 3, 4, 5]
> > +        - description: Write allocation policy
> > +          enum: [0, 2, 3, 4, 5]
> > +    description:
> > +      System-cache allocation policies for GPU architecture 11.0.3 and later.
> > +      Each entry contains a source ID, a read policy and a write policy.
> > +      Source IDs must be unique. Reserved source IDs and access directions
> > +      not supported by the GPU must use zero policies. Policy values are
> > +      0 for L2 allocation, 2 for never allocate, 3 for always allocate,
> > +      4 for partial allocation and 5 for L2 partial allocation. When present,
> > +      all source policies start at zero and the listed entries override them.
> > +      Omitted sources therefore use L2 allocation. If absent, the register
> > +      defaults are preserved.
> 
> Looks like integration specific, so implied by the compatible.
>

SYSC_ALLOC is a standard Mali GPU feature (architecture 11.0.3 and
later), not a Sky1-specific register, so other SoCs integrating these
GPUs may also need different allocation policies depending on their
system cache integration.

On CIX Sky1, devices on the MMHUB bus (such as the display controller)
cannot access the system-level cache. Buffers shared between the GPU and
MMHUB devices therefore require specific SYSC_ALLOC policies, otherwise
the GPU display output is corrupted.

In v2, these policies were in the driver via panthor_soc_data, similar
to the MediaTek mt8196 asn_hash table. I moved them to DT in v3 and
split them into this patch following Liviu's and Daniel's review on v2
so we could discuss the representation here.

Krzysztof, Liviu, Daniel: should I drop arm,sysc-alloc from DT and
derive the policies from "cix,sky1-mali" in the driver, or keep a
DT property?


Best regards,
Cunyuan
