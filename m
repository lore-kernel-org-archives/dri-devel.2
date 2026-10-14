Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900ABCC6B3B
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFCED11212C;
	Thu, 15 Oct 2026 07:56:37 +0000 (UTC)
X-Greylist: delayed 421 seconds by postgrey-1.36 at gabe;
 Wed, 14 Oct 2026 15:25:06 UTC
Received: from ix-euc1.prod.hydra.sophos.com (ix-euc1.prod.hydra.sophos.com
 [94.140.18.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC22110E9A1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:25:06 +0000 (UTC)
Received: from id-euc1.prod.hydra.sophos.com
 (ip-172-20-1-160.eu-central-1.compute.internal [172.20.1.160])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 by ix-euc1.prod.hydra.sophos.com (Postfix) with ESMTPS id 4j4Zb12vp6z440L
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:18:05 +0000 (UTC)
Received: from localhost (ip-172-20-0-158.eu-central-1.compute.internal
 [127.0.0.1])
 by id-euc1.prod.hydra.sophos.com (Postfix) with ESMTP id 4j4ZZz1zPJzYcp5
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:18:03 +0000 (UTC)
X-Sophos-Product-Type: Gateway
X-Sophos-Email-ID: 457ee17bb9f94c929892741028653095
Received: from FR6P281CU001.outbound.protection.outlook.com
 (mail-germanywestcentralazon11020120.outbound.protection.outlook.com
 [52.101.171.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp384r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by relay-eu-central-1.prod.hydra.sophos.com (Postfix) with ESMTPS id
 4j4ZZx0Nt3zMkrf; Wed, 14 Oct 2026 15:18:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Se33of4j3tcEFGLwfJbWmrByvmwNLuUUIDOD/uZIdV3YGdOQerzL0CoNH9nixzHrfCNGLbeTH4nO2WeS7zDJcOj78Rmo05ZRn33mfSP8W0wO1WjR1qDHfa7aBH+L1hoaRHUFTnAEle2KokgIpLtt6R1gUd7qr0p6xbvTHzXqreWwakvfHwvyZFmAjc9jnKLSRqb339B8Hfo1cUA1frLLZZZrAiAun0fe21Q0I4FzDxNyim1FEBCypO4Xo3P10X9fVOLA6fdo0nEt8PJmuA7PP561fVQa9E3HFexQE0ywkSGThNe+Y/curNtRXaiMU7dF78u57eUFrTTAyvpYNXNZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRA+M8WjyWlOsBllBma78ee66A1SCtR6P6nbXyIp5Ts=;
 b=fDIH2uOgRYq2bUMNTzHeg6HX7ZVmVIqhWIOOyTg7LhnnOo+sM+R0ORSj1XwJdOrtck+a7M3x8KJy06bMUOwB/n3afQXk/tEDtqTCGfBILLAvC1ZWYpQXXJV54nke5oYMZUkK6lhlKDk/0BaniFrlHecaPycQnNwHPLBJskNW4YrxnPxxuu8pUf/oH639O/baZOtQEkUcySrF+ZGVBFKHFnMKB2a4wJPC1ihEvEmOzgCHmTjmw12vBg03uGMyfkL94BRJbgKKzdAD+gEitxt8tMmTR7/Xf8KndQ/Xik0IAoLapbIzOVOePB2oca8pNgu+lSHhoVnJzKtKQufjNoGadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=igalia.com smtp.mailfrom=toowoxx.de;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=toowoxx.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791991068; 
 s=sophosac414cbf44944f6c8d3e625c445e3d53; d=toowoxx.de;
 h=From:CC:To:Subject:Date:Content-Type;
 bh=yRA+M8WjyWlOsBllBma78ee66A1SCtR6P6nbXyIp5Ts=;
 b=IsA1NyUTcMZkDBfmZ/z9CYE5KWnFR70yyPH+7mmdGoFUQmoGJVMF+dz+YTRilYcA
 rxpikemsayejOzaTo6a9+NtcDk84dz5EH/H2HN76hG3j4n55GvFHHlLb7x+SaKY6EmN
 cUCDxky+6+zS0PsjGN2vECcYhqtZVTLSCGL/Lau0aCwxOSgcQF5GhVajJasLgiprZhy
 9N+n3STfFNCxbgnaA9NL+vNFnxnhFcL9qwy74kdrkpp1bFe+yXOjP0+iXoDAGkO3A+o
 Mse6P5JlyZGxvTxlFWiW3xH4QOfE4f1Jr3Fbfl5zY1Ehl6lSH6gjYrEfDxhLn12+9Yz
 OSgUVWw55Q==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791991068; 
 s=v1; d=mail-dkim.eu-central-1.prod.sophossmtp.com;
 h=From:CC:To:Subject:Date:Content-Type;
 bh=yRA+M8WjyWlOsBllBma78ee66A1SCtR6P6nbXyIp5Ts=;
 b=bNHlzflEX7jq7XSSbGKWH3cldS5sJG8q9Lpn6u3Q+QC2TUqSOkJNqDc+yd19dz2a
 L1Uz+WWy4RJfcdAYWnKDCf+wfS0zIi204F9XnV5zFAdP+hosD+dKtZGaE64Fl/Lg4Ia
 Hy9td0GMKlTEI4BT5o+tJ09SNxOWLWrkfsiOBabSpkOqKGdQ/CmLRrJqslATf2XM+9S
 c/7KaW3ae5TLE5uyuQZ50Po5hr0NAGM4UFMOaCLlf2jEz+T7i893MkzAdekKrfR1/KG
 0Witgcp9SKCMCxni3me2HQP9nhyKWrrcLOsGel7BLKGawAgHAFcl3IIHJC2h5BWMktT
 HgZZooc5JQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791991068; 
 s=v1; d=mail-dkim-eu-central-1.prod.hydra.sophos.com;
 h=From:CC:To:Subject:Date:Content-Type;
 bh=yRA+M8WjyWlOsBllBma78ee66A1SCtR6P6nbXyIp5Ts=;
 b=qcSWhrNZ/XhvrYdnkdYWN+wSXqUfRkRgzhipSFFS/zY9E/keYG6ca7Kcq7aKpeQF
 0a20wr8jZ/Gy/AeSIG+RwAzk2F+6uEuSliB7mtmeqTkAKAVLOaBbm2f+rxtD13dz9N6
 fKfoM/WTS6tHGapSPNr2SW1WM4MAKNpmdFenl+1pVYGHomvV8dew1rE/Qy8fM268Jrh
 yVxAWmbQ9yJWFAxgFdz3/4bOU34URhjzAL/uRHcTrH7RDNfBkFjcBH/9SNRgQvWDm1n
 1CCw33faiI+g4MtccVcQbtoCL9YA6hOrxqsyitG8q5483A55x7QXDyy4MWhUB6itvQA
 Du7pgcJMLw==
Received: from DU7P250CA0002.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::15)
 by FR2P281MB1736.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 15:17:56 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::7e) by DU7P250CA0002.outlook.office365.com
 (2603:10a6:10:54f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 15:17:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195)
 smtp.mailfrom=toowoxx.de; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=toowoxx.de;
Received-SPF: Pass (protection.outlook.com: domain of toowoxx.de designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 15:17:54 +0000
Content-Type: multipart/related;
 boundary="_f3865e20-426a-4c61-9f60-e0715bf05adf_"
Received: from FR4P281CU032.outbound.protection.outlook.com (40.93.78.52) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Wed, 14 Oct 2026 15:17:53 +0000
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=toowoxx.de;
Received: from BE1P281MB1956.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:41::6) by
 BEUP281MB3413.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:9e::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Wed, 14 Oct 2026 15:17:50 +0000
Received: from BE1P281MB1956.DEUP281.PROD.OUTLOOK.COM
 ([fe80::87ee:4b41:952a:8b36]) by BE1P281MB1956.DEUP281.PROD.OUTLOOK.COM
 ([fe80::87ee:4b41:952a:8b36%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 15:17:50 +0000
Message-ID: <69100e57-9ca9-4ff5-b8c8-fc087244976e@toowoxx.de>
Date: Wed, 14 Oct 2026 17:17:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/amdgpu: fix memleak when amdgpu_vm_ptes_update
 fails
Content-Language: en-US
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Chunming Zhou
 <david1.zhou@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Natalie Vock <nat@pixelcluster.dev>
CC: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
References: <20260929-amdgpu_vm_update_funcs_abort-v1-0-a8072140a7db@igalia.com>
 <8f533a48-3e40-418f-8155-5d09572834b8.bea56be8-1518-494d-8b16-c514e825d963.8771c778-bb79-4752-8713-e4313b5951e5@emailsignatures365.codetwo.com>
From: Simao Gomes Viana <simao.gomes@toowoxx.de>
In-Reply-To: <20260929-amdgpu_vm_update_funcs_abort-v1-0-a8072140a7db@igalia.com>
X-ClientProxiedBy: FR4P281CA0288.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::19) To BE1P281MB1956.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:41::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: BE1P281MB1956:EE_|BEUP281MB3413:EE_|DB1PEPF000509EF:EE_|FR2P281MB1736:EE_
X-MS-Office365-Filtering-Correlation-Id: 3368effb-eb88-49b2-d2f8-08df2a065253
X-PassedThroughToowoxxEOP: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|7416014|366016|376014|261009223027099003|10067099003|921020|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: cI1kRlVfCb7DaJNwZBWjVXm6czdJFxMc6GzD7FPv2ihgu79NuHj58x5PlQmGsqg1x+tPSbgGl3PofCtax70wPcZ8A3tsW8QNeOsjzGkpDrFkwqkfQy8j2TIPAix6+6+FoN6yf0XHLDJk84iPBlk8oNsrsKxC4WbsZdPCV4MLRDWx1ka5tZGymomEwG7SsdojJyusZvpUcOcWyWeqvMvpNxmymrXt4ntagCj4SAgQMYor0qMkdG9OmoO82uqHRwLR5TF3n0mq3JD50hOpR/bMyKbrC5PcV8FpnU6LoP+Aot3ySV3jpS/ntGdNDgIzcuzizpV7aUKI9iQTIbLDRJGDixrya0BXmMxYwTUJeTn7VBBjDher7KbERSU6I2IrryGOkDpcJe21LI9jEkpdGx1Rjik5XQYPEY2cKBhj1IRSCT76gODaYHQJGIf87jahAHExfk4yKO61zhNimO4IZlDhPtVP/j8oAr00eX9zZ0KuiLc6p+1SW4Aet7hYmO/WqNQm5GtMg3UnDOHm91z/sRmL5huukz2qSLyypxRU8ljvcukED8IlvkIVu9NFtrDOpeQURy+hPFJ34/rplCs+vWRPNruYQqkt+wQL99k2hUGFO8ow8AwHtBJhyEpOqIopTa7HWAl/wj+8errPPAsVe24L1Z7Pp8dndVTHh+mXEoJy230GVAIxVFlcSxRsuH6gIewREfJiAs6IFTaQGQdayNKeUg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:BE1P281MB1956.DEUP281.PROD.OUTLOOK.COM; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(7416014)(366016)(376014)(261009223027099003)(10067099003)(921020)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-Exchange-RoutingPolicyChecked: s5e75TTAT5MKo2jQBkACf6q+Sck56Fk4DAmmCrSEzaxOIy+A83i8YXESHjKsGMjRcAMDtjJYiW5wpSaQ4D2VRkkSpEA6cSKoqQovDknvf+jtQqAR0m3NDJeZssACX+X459j8xcsCmHQOrPYqlcIAIIgW5jfYVdl9nBOkDGyLhWeCrHcam9KZYFUbNOogE8ckRGRZfHZxIsSVssL7LDeHxpig04ZcXXbxh0mHt96mKSOSbIWRp+0Goxa4J/n8aRQiuncsRGNAvrSM/qaEbAL0kwpj6cqhSNwZ2x/bxt+RxESS7M996wTGfgxxC6ywGr/AYqT3KEwpBnSv5GzqI9zPlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3413
X-CodeTwo-MessageID: ab0230c7-4cb6-4a12-8ed8-f7aae8def069.20261014151753@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bde566ec-3c36-4ec3-5b86-08df2a064f2a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|376014|7416014|35042699022|1800799024|7049299003|6049299003|3109299003|23010399003|82310400026|7149299003|36860700016|921020|56012099006|5023799004|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|4053099003|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: xnutmoRy2Sdolbq5HcWHw4+3L+lWojpyGUO+equqA3+Ta+vS+Bk2mDxUe7Xv5LFXnv5E2mt4S3T3YXoUK2aFsfa4LT0HAMweheTB7PVg5IrJtdKStsv4ZT7l20Be0hx0zBF60pHMAtQgq71t4J8GfwvI8Ud5HQpR+JEI7rGIDtjRA+Hvzh2I1ACX7KLUgMoQxb4q3jDTlVOKyaAQTXhObB7EdbsmVb0g2l+9xnsEHzKoBYDZS8bGoTVnbZHwBdwQpdz+/HkyrFmM5pg6JnQg5xAFPI/9ngqraUI/VotW/kQaAtqQxtGCOgxcgtSJ3pWEMVUkwCzCh5uztlRwswp31qD3rqJqEAOQeKaCFHmG2t62kZClhcy4cHsDolyiSD/KVOwUu1seAtsu/6Tf/V7zyHJlhp0NVj+aWwASzpe2oyoaOFbQw4IeQTp2o3EAWlFoXZPL4YZCsO2k6+N1KDM8Uj3YZ0usuCG4xleHuwVTR4qcQTf6YIygli9ZLxlAdAd5XPm5UcZqC5mUkYV3a6K66ha2TzrH5lF3Bhf+SQvsExImS0GxD30C8adMktMh7ElX6FDGixv1DLtGdSxWsWqUDMs0lq8zTFDvSoTLKa2uu8ae8GggGoJ5rRwRRMAXfP+Zhuz4TpU7dLcvg6lM57pYhME6nEOjZtR1doyOUZPTYlYEhtADUFbu8B5ezBtg01Zx
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(14060799003)(376014)(7416014)(35042699022)(1800799024)(7049299003)(6049299003)(3109299003)(23010399003)(82310400026)(7149299003)(36860700016)(921020)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(4053099003)(13003099007)(8096899003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jo7bITYNLzEO0ROA3RH63Yz/5R10M1YLGl57c6ZpGJr9x23zHxgKj+19aPEMVoNHjRSH8cV7m4G3X9da2Oad0UHhogiK9R3ta/XS0BACQrzTDfdkbY3sxuiO7a1+ay09grYCjhjwZoa1HR6snAd5xiZiR76decCcrsxzCeQdCXKLRZrLWKAiQrLOSfQvU0gI9f1OQ4GW5fLZBLWiytqpuX/rsKYlLKAKcFs9Ihz44ZtNITLkLI7sJszmvarivxjmCFtIff6BsXnNWvfgTIoVLB2Jmjev83xnztq2KW8276WexHbJVVSPgKuMnzREkDytqHZBI4tKdoHdgrTYG9R7eQFSqqxQ/y4JMskGFfzT4wfay87496Q5V9uA0HSkIuDkEdROUx3zgvWIF7pHVg7HQMwvWm4sHlT4W8Don6dns+iNLCv6LkuYRjTp9WrpMxjV
X-OriginatorOrg: toowoxx.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:17:54.7087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3368effb-eb88-49b2-d2f8-08df2a065253
X-MS-Exchange-CrossTenant-Id: b1c82204-1152-412f-aab0-4eb7318fffc0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=b1c82204-1152-412f-aab0-4eb7318fffc0; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1736
X_Sophos_TLS_Connection: PRE_TLS_1_3
X_Sophos_TLS_Delivery: true
X-Sophos-Email-Transport-Route: pref_tls_13:
X-Lased-Spamprobability: 0.114052
X-Lased-Impersonation: False
X-Lased-Hits: BODYTEXTH_SIZE_3000_MORE 0.000000, BODY_SIZE_10000_PLUS
 0.000000, BODY_SIZE_100K_PLUS 0.000000, BODY_SIZE_25K_PLUS 0.000000,
 BODY_SIZE_50K_PLUS 0.000000, BODY_SIZE_75K_PLUS 0.000000, DKIM_ALIGNS
 0.000000, DKIM_SIGNATURE 0.000000, FROM_NAME_PHRASE 0.000000, HTML_NO_HTTP
 0.100000, IMG_ATTACHED_2P 0.000000, IMP_FROM_NOTSELF 0.000000,
 INVOICE_ATTACHMENT 0.100000, IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000,
 MSGID_SAMEAS_FROM_HEX_844412 0.100000, MSG_THREAD 0.000000, MSG_THREAD_SOLO
 0.000000, MULTIPLE_ATTACHMENTS 0.000000, MULTIPLE_RCPTS 0.100000,
 MULTIPLE_REAL_RCPTS 0.000000, NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER
 0.000000, NO_URI_HTTPS 0.000000, OBFU_SHORT_10CHARS 0.500000, OUTBOUND
 0.000000, OUTBOUND_SOPHOS 0.000000, PNG_PIXPERBYTE_LOW 0.000000, REFERENCES
 0.000000, SUSP_DH_NEG 0.000000, USER_AGENT 0.000000, __ANY_URI 0.000000,
 __ARCAUTH_DKIM_NONE 0.000000, __ARCAUTH_DMARC_PASSED 0.000000,
 __ARCAUTH_PASSED 0.000000, __ARC_SEAL_MICROSOFT 0.000000,
 __ARC_SIGNATURE_MICROSOFT 0.000000, __ATTACH_CTE_BASE64 0.000000,
 __ATTACH_CTE_QUOTED_PRINTABLE 0.000000, __AUTH_RES_ORIG_DKIM_NONE 0.000000,
 __AUTH_RES_ORIG_DMARC_NONE 0.000000, __BODY_NO_MAILTO 0.000000,
 __BODY_TEXT_X4 0.000000, __BODY_VOICEMAIL 0.000000, __BOUNCE_CHALLENGE_SUBJ
 0.000000, __BOUNCE_NDR_SUBJ_EXEMPT 0.000000, __BULK_NEGATE 0.000000, __CT
 0.000000, __CTYPE_HAS_BOUNDARY 0.000000, __CTYPE_MULTIPART 0.000000,
 __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN
 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
 __EXTRA_MPART_TYPE_N1 0.000000, __FRAUD_MONEY_CURRENCY 0.000000,
 __FRAUD_MONEY_CURRENCY_DOLLAR 0.000000, __FUR_RDNS_SOPHOS 0.000000,
 __HAS_ATTACHMENT 0.000000, __HAS_ATTACHMENT1 0.000000, __HAS_ATTACHMENT2
 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_HTML 0.000000,
 __HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000, __HAS_X_FF_ASR 0.000000,
 __HAS_X_FF_ASR_CAT 0.000000, __HAS_X_FF_ASR_SFV 0.000000, __HTML_BAD_END
 0.000000, __HTML_ENTITIES_X4 0.000000, __HTML_TAG_DIV 0.000000,
 __IMG_ATTACHED 0.000000, __IMG_SIZE_1K_10K 0.000000, __IMP_FROM_MY_ORG
 0.000000, __IMP_FROM_NOTSELF_MULTI 0.000000, __INT_PROD_COMP 0.000000,
 __INVOICE_MULTILINGUAL 0.000000, __IN_REP_TO 0.000000,
 __JSON_HAS_SCHEMA_VERSION 0.000000, __JSON_HAS_TENANT_DOMAINS 0.000000,
 __JSON_HAS_TENANT_ID 0.000000, __JSON_HAS_TENANT_SCHEMA_VERSION 0.000000,
 __JSON_HAS_TENANT_VIPS 0.000000, __JSON_HAS_TRACKING_ID 0.000000,
 __MAIL_CHAIN 0.000000, __MIME_ATTACHMENT_1_N 0.000000,
 __MIME_ATTACHMENT_N_2 0.000000, __MIME_ATTACHMENT_N_3 0.000000,
 __MIME_ATTACHMENT_N_4 0.000000, __MIME_HTML 0.000000, __MIME_TEXT_H
 0.000000, __MIME_TEXT_H1 0.000000, __MIME_TEXT_H2 0.000000, __MIME_VERSION
 0.000000, __MOZILLA_USER_AGENT 0.000000, __MSGID_HEX_844412 0.000000,
 __MULTIPLE_RCPTS_CC_X2 0.000000, __MULTIPLE_RCPTS_TO_X2 0.000000,
 __MULTIPLE_RCPTS_TO_X5 0.000000, __OUTBOUND_SOPHOS 0.000000,
 __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
 __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PART_2_IMAGE_PNG 0.000000,
 __PHISH_SPEAR_SUBJ_PREDICATE 0.000000, __PNG_WIDTH_100 0.000000,
 __PRODUCT_TYPE_GATEWAY 0.000000, __RATWARE_SIGNATURE_3_N1 0.000000,
 __RCVD_PASS 0.000000, __REFERENCES 0.000000, __SANE_MSGID 0.000000,
 __SCAN_D_NEG 0.000000, __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
 __SCAN_D_NEG_HEUR2 0.000000, __SHIPPING_PHRASE 0.000000, __SL_HEAVY
 0.000000, __STYLE_RATWARE_NEG 0.000000, __STYLE_TAG 0.000000,
 __SUBJ_ALPHA_END 0.000000, __SUBJ_ALPHA_NEGATE 0.000000, __SUBJ_REPLY
 0.000000, __TAG_EXISTS_BODY 0.000000, __TAG_EXISTS_HEAD 0.000000,
 __TAG_EXISTS_HTML 0.000000, __TAG_EXISTS_META 0.000000, __TO_MALFORMED_2
 0.000000, __TO_NAME 0.000000, __TO_NAME_DIFF_FROM_ACC 0.000000,
 __TO_REAL_NAMES 0.000000, __URI_MAILTO 0.000000, __URI_NO_WWW 0.000000,
 __URI_NS 0.000000, __USER_AGENT 0.000000, __X_FF_ASR_SCL_NSP 0.000000,
 __X_FF_ASR_SFV_NSPM 0.000000
X-Sophos-Email: [eu-central-1] Antispam-Engine: 6.0.3, AntispamData:
 2026.10.14.22719
X-Lased-Spam: NonSpam
X-Sophos-MH-Mail-Info-Key: NGo0WmIxMnZwNno0NDBMLTE3Mi4yMC4xLjQ0
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

--_f3865e20-426a-4c61-9f60-e0715bf05adf_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text -->
<style>.EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800=
000 2px solid; }</style></head>
<body>
<font size=3D"2"><div class=3D"PlainText">On Tue, Sep 29, 2026 at 05:34:03P=
M -0300, Thadeu Lima de Souza Cascardo wrote:<br>
&gt; When amdgpu_vm_ptes_update fails, there might be an IB jobs leak.<br>
<br>
On 7.2.9 this leak ends with command submission blocked in the kernel<br>
until a reboot, so I tested a backport of the series there.<br>
<br>
The leaked job keeps its IB, and that IB never gets a fence, so it<br>
stays in the delayed IB pool for good. drm_suballoc_try_free() stops<br>
at the first entry without a fence, and drm_suballoc_next_hole() can<br>
only skip ahead to an entry that has one. Once a request does not fit<br>
in front of a leaked IB and no fenced entry is left to skip to,<br>
amdgpu_sa_bo_new() sleeps uninterruptibly in drm_suballoc_insert(),<br>
although the rest of the 1 MiB pool may be free. Later page table<br>
updates that need an IB from that pool block the same way.<br>
<br>
I hit this on a Framework Desktop (Ryzen AI Max&#43; 395, Radeon 8060S,<br>
512 MiB VRAM carve-out) running Vulkan compute with 62 GiB in GTT. Page<br>
tables can only be placed in VRAM, which was full at the hang (512 of<br>
512 MiB). That boot logged 239 &quot;Couldn't update BO_VA (-12)&quot;, and=
 I<br>
did not trace which allocation failed. The first command submission<br>
after the last of them never returned, with the GPU idle:<br>
<br>
&nbsp; INFO: task qwen38_vk:3765381 blocked for more than 122 seconds.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not tainted 7.2.9 #1-NixOS<br>
&nbsp; Call Trace:<br>
&nbsp;&nbsp; &lt;TASK&gt;<br>
&nbsp;&nbsp; __schedule&#43;0x413/0x1780<br>
&nbsp;&nbsp; schedule&#43;0x27/0xa0<br>
&nbsp;&nbsp; drm_suballoc_insert&#43;0x5de/0x680 [drm_suballoc_helper]<br>
&nbsp;&nbsp; drm_suballoc_new&#43;0x47/0x220 [drm_suballoc_helper]<br>
&nbsp;&nbsp; amdgpu_sa_bo_new&#43;0x1e/0x40 [amdgpu]<br>
&nbsp;&nbsp; amdgpu_ib_get&#43;0x42/0xa0 [amdgpu]<br>
&nbsp;&nbsp; amdgpu_job_alloc_with_ib&#43;0x78/0xe0 [amdgpu]<br>
&nbsp;&nbsp; amdgpu_vm_sdma_prepare&#43;0x4a/0xb0 [amdgpu]<br>
&nbsp;&nbsp; amdgpu_vm_update_range&#43;0x22f/0x940 [amdgpu]<br>
&nbsp;&nbsp; amdgpu_vm_bo_update&#43;0x261/0x740 [amdgpu]<br>
&nbsp;&nbsp; amdgpu_vm_handle_moved&#43;0x60/0x1e0 [amdgpu]<br>
&nbsp;&nbsp; amdgpu_cs_ioctl&#43;0x1a19/0x2380 [amdgpu]<br>
&nbsp;&nbsp; drm_ioctl_kernel&#43;0xae/0x100<br>
&nbsp;&nbsp; drm_ioctl&#43;0x27e/0x5b0<br>
&nbsp;&nbsp; amdgpu_drm_ioctl&#43;0x4a/0x80 [amdgpu]<br>
&nbsp;&nbsp; __x64_sys_ioctl&#43;0x97/0xe0<br>
&nbsp;&nbsp; do_syscall_64&#43;0x134/0x6b0<br>
&nbsp;&nbsp; entry_SYSCALL_64_after_hwframe&#43;0x77/0x7f<br>
<br>
To reproduce it on demand, I limited failslab to the test task and,<br>
with its stack filter, to allocations below amdgpu_vm_ptes_update().<br>
The injected -ENOMEM hits the first slab allocation made while a page<br>
table is created, which need not be where the real failure happened.<br>
The program at the end maps a 4 KiB BO at &lt;count&gt; addresses with<br>
injection on, so every map fails while allocating a page table, after<br>
amdgpu_vm_sdma_prepare() allocated the job. With injection off, one<br>
more map then updates the page tables of all earlier mappings, and the<br>
unmaps clear them again, so both take IBs from the same pool. In<br>
amdgpu_sa_info, an IB without &quot;protected by&quot; belongs to no submit=
ted<br>
job, so after the run it is a leaked one.<br>
<br>
Results on 7.2.9 without and with the backported series:<br>
<br>
Each kernel ran 64 maps and then 2048 maps in one boot, with nothing<br>
else using the GPU.<br>
<br>
Without the series:<br>
&nbsp; 64 maps: 64 injected failures and 64 &quot;Couldn't update BO_VA (-1=
2)&quot;.<br>
&nbsp;&nbsp;&nbsp; 64 IBs without a fence stayed in the delayed pool (64 Ki=
B), and<br>
&nbsp;&nbsp;&nbsp; the program finished.<br>
&nbsp; 2048 maps: after 960 failed maps the program blocked in<br>
&nbsp;&nbsp;&nbsp; drm_suballoc_insert(), called from amdgpu_vm_sdma_prepar=
e() in<br>
&nbsp;&nbsp;&nbsp; amdgpu_gem_va_ioctl(). The delayed pool then held 1024 I=
Bs of<br>
&nbsp;&nbsp;&nbsp; 1 KiB without a fence, 64 of them from the first run, wh=
ich is<br>
&nbsp;&nbsp;&nbsp; the whole 1 MiB pool. The task stayed in D state, throug=
h a<br>
&nbsp;&nbsp;&nbsp; SIGKILL, until the reboot.<br>
<br>
With the series:<br>
&nbsp; 64 maps: 64 injected failures and 64 &quot;Couldn't update BO_VA (-1=
2)&quot;,<br>
&nbsp;&nbsp;&nbsp; no IB without a fence left, all 65 unmaps done.<br>
&nbsp; 2048 maps: 2048 injected failures and 2048 &quot;Couldn't update BO_=
VA<br>
&nbsp;&nbsp;&nbsp; (-12)&quot;, no IB without a fence left, all 2049 unmaps=
 done, no task<br>
&nbsp;&nbsp;&nbsp; in D state.<br>
<br>
For 7.2.9 I backported both patches. There, struct<br>
amdgpu_vm_update_funcs is in amdgpu_vm.h, the map path is still<br>
amdgpu_vm_update_range() and ends with amdgpu_vm_eviction_unlock(),<br>
and the hunks of patch 1 for amdgpu_vm_unmap_range() and<br>
amdgpu_vm_handle_fault() have no counterpart. The added and removed<br>
lines are the same, only the context differs.<br>
<br>
As this blocks command submission until a reboot on 7.2.9, could<br>
patch 2, with patch 1 as its prerequisite, be tagged for stable? The<br>
backport to 7.2.9 needed only the changes above.<br>
<br>
Claude Code (Claude Opus 5.5) did the source analysis, the backport,<br>
the test program and script, ran the tests on my machine and drafted<br>
this mail.<br>
<br>
Tested-by: Simao Gomes Viana &lt;simao.gomes@toowoxx.de&gt; # 7.2.9 backpor=
t<br>
<br>
Reproducer. It needs CONFIG_FAILSLAB, CONFIG_FAULT_INJECTION_DEBUG_FS<br>
and CONFIG_FAULT_INJECTION_STACKTRACE_FILTER, and root. The range of<br>
amdgpu_vm_ptes_update() comes from /proc/kallsyms (readable with<br>
kptr_restrict at most 1), and its end is the next higher symbol<br>
address. The other failslab attributes stay at their defaults.<br>
<br>
&nbsp; cd /sys/kernel/debug/failslab<br>
&nbsp; echo N &gt; ignore-gfp-wait<br>
&nbsp; echo Y &gt; task-filter<br>
&nbsp; echo -1 &gt; times<br>
&nbsp; echo 0x&lt;start&gt; &gt; require-start<br>
&nbsp; echo 0x&lt;end&gt; &gt; require-end<br>
&nbsp; echo 100 &gt; probability<br>
<br>
&nbsp; gcc -O2 -o vm-map-fail vm-map-fail.c \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(pkg-config --cflags --libs libdrm_amdgpu)<=
br>
&nbsp; ./vm-map-fail /dev/dri/renderD128 64<br>
<br>
/*<br>
&nbsp;* Maps one 4 KiB buffer at &lt;count&gt; GPU addresses 2 MiB apart wi=
th<br>
&nbsp;* /proc/self/make-it-fail set. With failslab limited to that flag and=
 to call<br>
&nbsp;* chains through amdgpu_vm_ptes_update(), every map fails in its page=
 table<br>
&nbsp;* allocation after amdgpu_vm_sdma_prepare() allocated the update job,=
 and the<br>
&nbsp;* kernel logs &quot;Couldn't update BO_VA (-12)&quot; for it.<br>
&nbsp;*<br>
&nbsp;* Then, with the flag cleared, one more map retries the page table up=
dates of<br>
&nbsp;* all &lt;count&gt; earlier mappings, which now allocate their page t=
ables and<br>
&nbsp;* submit their jobs, and the unmaps clear them again, one job each. B=
oth need<br>
&nbsp;* IBs from the same pool the failed maps took theirs from.<br>
&nbsp;*<br>
&nbsp;* Writing make-it-fail needs CAP_SYS_RESOURCE.<br>
&nbsp;*<br>
&nbsp;*&nbsp;&nbsp; vm-map-fail &lt;render node&gt; &lt;count&gt;<br>
&nbsp;*/<br>
#include &lt;amdgpu.h&gt;<br>
#include &lt;amdgpu_drm.h&gt;<br>
#include &lt;fcntl.h&gt;<br>
#include &lt;stdio.h&gt;<br>
#include &lt;stdlib.h&gt;<br>
#include &lt;string.h&gt;<br>
#include &lt;unistd.h&gt;<br>
<br>
#define BO_SIZE 4096ull<br>
#define STRIDE (2ull &lt;&lt; 20)<br>
<br>
static void check(int r, const char *what)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; fprintf(stderr, &quot;%s: %s\n&quot;, what, strerror(-r));<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; exit(1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
}<br>
<br>
static void set_make_it_fail(const char *value)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int fd =3D open(&quot;/proc/self=
/make-it-fail&quot;, O_WRONLY);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fd &lt; 0 || write(fd, value=
, 1) !=3D 1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; perror(&quot;/proc/self/make-it-fail&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; exit(1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(fd);<br>
}<br>
<br>
static void va_op_all(amdgpu_bo_handle bo, uint64_t base, unsigned int coun=
t,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t op, const char=
 *what)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (unsigned int i =3D 0; i &lt=
; count; i&#43;&#43;)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; check(amdgpu_bo_va_op(bo, 0, BO_SIZE, base &#43; i * STRIDE=
, 0, op),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; what);<br>
}<br>
<br>
int main(int argc, char **argv)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_alloc_request r=
equest =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .alloc_size =3D BO_SIZE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .phys_alignment =3D BO_SIZE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .preferred_heap =3D AMDGPU_GEM_DOMAIN_GTT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_handle dev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_va_handle va;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_handle bo;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t major, minor;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t base;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int fd;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (argc !=3D 3 || (count =3D st=
rtoul(argv[2], NULL, 10)) =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; fprintf(stderr, &quot;usage: %s &lt;render node&gt; &lt;cou=
nt&gt;\n&quot;, argv[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fd =3D open(argv[1], O_RDWR | O_=
CLOEXEC);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fd &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; perror(argv[1]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check(amdgpu_device_initialize(f=
d, &amp;major, &amp;minor, &amp;dev),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &quot;amdgpu_device_initialize&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check(amdgpu_bo_alloc(dev, &amp;=
request, &amp;bo), &quot;amdgpu_bo_alloc&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check(amdgpu_va_range_alloc(dev,=
 amdgpu_gpu_va_range_general,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (count &#43; 1=
) * STRIDE, STRIDE, 0, &amp;base, &amp;va,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &quot;amdgpu_va_range_alloc&quot;);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_make_it_fail(&quot;1&quot;);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_op_all(bo, base, count, AMDGP=
U_VA_OP_MAP, &quot;map&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_make_it_fail(&quot;0&quot;);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check(amdgpu_bo_va_op(bo, 0, BO_=
SIZE, base &#43; count * STRIDE, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VA_OP_MAP),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &quot;map without failure injection&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_op_all(bo, base, count &#43; =
1, AMDGPU_VA_OP_UNMAP, &quot;unmap&quot;);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check(amdgpu_va_range_free(va), =
&quot;amdgpu_va_range_free&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check(amdgpu_bo_free(bo), &quot;=
amdgpu_bo_free&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check(amdgpu_device_deinitialize=
(dev), &quot;amdgpu_device_deinitialize&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(fd);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;%u failed maps from=
 0x%llx, %llu bytes apart, then 1 map and %u unmaps\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; count, (unsigned long long)base, STRIDE, count &#43; 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
}<br>
</div></font>
=0A=
=0A=
=0A=
<p style=3D"FONT-SIZE: 10pt; MARGIN-BOTTOM: 5pt; FONT-FAMILY: ARIAL; MARGIN=
-TOP: 0pt"></p><br>=0A=
<table id=3D"0.rt2nciqm8el" style=3D"width: 431px;" cellspacing=3D"0" cellp=
adding=3D"0">=0A=
  <tbody>=0A=
  <tr>=0A=
    <td style=3D"border-width: 0px 2px 0px 0px; font-size: 10pt; font-famil=
y: Arial; border-right-style: solid; border-color: rgb(255, 255, 255) rgb(9=
9, 143, 193) rgb(255, 255, 255) rgb(255, 255, 255); width: 230px;" valign=
=3D"top" colspan=3D"2" class=3D""><span style=3D"FONT-SIZE: 13px; FONT-FAMI=
LY: Verdana">Mit freundlichen Gr&#xFC;&#xDF;en =0A=
      /</span><br style=3D"FONT-SIZE: 13px; FONT-FAMILY: Verdana"><span sty=
le=3D"FONT-SIZE: 13px; FONT-FAMILY: Verdana">best regards,</span></td>=0A=
    <td style=3D"font-size: 10pt; font-family: Arial; width: 201px; padding=
: 0px 0px 0px 10px; text-align: left;" valign=3D"middle" colspan=3D"3"><a h=
ref=3D"https://www.toowoxx.de/" title=3D""><img src=3D"cid:logo-min_9a50926=
3-93aa-4c90-952e-cf3ad1644cc3.png" border=3D"0" id=3D"0.w3awvfulmsk" alt=3D=
"Logo_Toowoxx.png" style=3D""></a></td></tr>=0A=
  <tr>=0A=
    <td style=3D"border-width: 0px 2px 0px 0px; font-size: 10pt; font-famil=
y: Arial; border-right-style: solid; border-color: rgb(255, 255, 255) rgb(9=
9, 143, 193) rgb(255, 255, 255) rgb(255, 255, 255); width: 230px;" valign=
=3D"top" colspan=3D"2" class=3D""></td>=0A=
    <td style=3D"font-size: 10pt; font-family: Arial; width: 201px;" valign=
=3D"top" colspan=3D"3">&nbsp;<br></td></tr>=0A=
  <tr>=0A=
    <td style=3D"border-width: 0px 2px 0px 0px; border-right-style: solid; =
border-color: rgb(255, 255, 255) rgb(99, 143, 193) rgb(255, 255, 255) rgb(2=
55, 255, 255); width: 230px;" valign=3D"top" colspan=3D"2" class=3D""><font=
 face=3D"Verdana"><span style=3D"font-size: 13px;"><b>Simao Gomes Viana</b>=
</span></font></td>=0A=
    <td style=3D"font-size: 10pt; font-family: Arial; width: 201px; padding=
: 0px 0px 0px 10px;" valign=3D"top" colspan=3D"3"><span style=3D"FONT-SIZE:=
 13px; FONT-FAMILY: Verdana; FONT-WEIGHT: 700">Toowoxx IT =0A=
      GmbH</span></td></tr>=0A=
  <tr>=0A=
    <td style=3D"border-width: 0px 2px 0px 0px; font-size: 10pt; font-famil=
y: Arial; border-right-style: solid; border-color: rgb(255, 255, 255) rgb(9=
9, 143, 193) rgb(255, 255, 255) rgb(255, 255, 255); width: 230px;" valign=
=3D"top" colspan=3D"2"><span style=3D"FONT-SIZE: 13px; FONT-FAMILY: Verdana=
">Senior Developer</span></td>=0A=
    <td style=3D"font-size: 10pt; font-family: Arial; width: 201px; padding=
: 0px 0px 0px 10px;" valign=3D"top" colspan=3D"3"><span style=3D"FONT-SIZE:=
 13px; FONT-FAMILY: Verdana">Krumbacher Stra&#xDF;e =0A=
      1</span><br></td></tr>=0A=
  <tr>=0A=
    <td style=3D"border-width: 0px 2px 0px 0px; font-size: 10pt; font-famil=
y: Arial; border-right-style: solid; border-color: rgb(255, 255, 255) rgb(9=
9, 143, 193) rgb(255, 255, 255) rgb(255, 255, 255); width: 230px;" valign=
=3D"top" colspan=3D"2"></td>=0A=
    <td style=3D"font-size: 10pt; font-family: Arial; width: 201px; padding=
: 0px 0px 0px 10px;" valign=3D"top" colspan=3D"3"><span style=3D"FONT-SIZE:=
 13px; FONT-FAMILY: Verdana">DE-86489 =0A=
      Deisenhausen</span><br></td></tr>=0A=
  <tr>=0A=
    <td style=3D"border-width: 0px 2px 0px 0px; font-size: 10pt; font-famil=
y: Verdana; border-right-style: solid; border-color: rgb(255, 255, 255) rgb=
(99, 143, 193) rgb(255, 255, 255) rgb(255, 255, 255); width: 230px;" valign=
=3D"top" colspan=3D"2" class=3D""><br style=3D"font-family: Verdana;"></td>=
=0A=
    <td style=3D"font-size: 10pt; font-family: Arial; width: 201px; padding=
: 0px 0px 10px 10px;" valign=3D"top" colspan=3D"3"><br></td></tr>=0A=
  <tr>=0A=
    <td style=3D"border-width: 0px 2px 0px 0px; font-family: Verdana; borde=
r-right-style: solid; border-color: rgb(255, 255, 255) rgb(99, 143, 193) rg=
b(255, 255, 255) rgb(255, 255, 255); width: 230px; padding: 0px 0px 10px; t=
ext-align: left;" valign=3D"bottom" rowspan=3D"2" colspan=3D"2" class=3D"">=
<span style=3D"font-size: 13px; color: rgb(91, 138, 181); font-family: Verd=
ana;">E:</span><span style=3D"FONT-SIZE: 13px; FONT-FAMILY: Verdana; COLOR:=
 rgb(91,138,181)">&nbsp;</span><a style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Ve=
rdana; COLOR: rgb(91,138,181); text-decoration-line: none" href=3D"mailto:s=
imao.gomes@toowoxx.de">simao.gomes@toowoxx.de</a><br style=3D"font-family: =
Verdana;"><span style=3D"font-size: 13px; color: rgb(91, 138, 181); font-fa=
mily: Verdana;">T:</span><span style=3D"FONT-SIZE: 13px; FONT-FAMILY: Verda=
na; COLOR: rgb(91,138,181)">&nbsp;</span><a style=3D"FONT-SIZE: 10pt; FONT-=
FAMILY: Verdana; COLOR: rgb(91,138,181); text-decoration-line: none" href=
=3D"tel:+49 8282 881299-22">+49 8282 881299-22</a><br style=3D"font-family:=
 Verdana;"><span style=3D"font-size: 13px; color: rgb(91, 138, 181); font-f=
amily: Verdana;"></span><span style=3D"font-size: 13px; color: rgb(91, 138,=
 181); font-family: Verdana;"><span style=3D"font-size: 13px; color: rgb(91=
, 138, 181); font-family: Verdana;">W:&nbsp;</span><a title=3D"" style=3D"f=
ont-size: 10pt; color: rgb(91, 138, 181); text-decoration-line: none; font-=
family: Verdana;" href=3D"https://toowoxx.de/">toowoxx.de</a><br><span styl=
e=3D"font-size: 10pt; color: rgb(91, 138, 181);">Teams:&nbsp;</span><a href=
=3D"https://teams.microsoft.com/l/chat/0/0?users=3Dsimao.gomes@toowoxx.de" =
style=3D"color: rgb(91, 138, 181); text-decoration-line: none; background-c=
olor: rgb(255, 255, 255); font-size: 10pt;" title=3D"">Simao Gomes Viana | =
Toowoxx IT GmbH</a></span></td>=0A=
    <td style=3D"font-family: Arial; width: 201px;" valign=3D"top" colspan=
=3D"3"></td></tr>=0A=
  <tr>=0A=
    <td style=3D"font-family: Arial; width: 201px; padding: 0px 0px 10px 10=
px; text-align: left;" valign=3D"bottom" colspan=3D"3"><span style=3D"FONT-=
SIZE: 13px; FONT-FAMILY: Verdana; COLOR: rgb(91,138,181)">Standort =0A=
      Ulm</span><br><span style=3D"FONT-SIZE: 13px; FONT-FAMILY: Verdana; C=
OLOR: rgb(0,0,0)">M&#xFC;nchner =0A=
      Stra&#xDF;e 15</span><br><span style=3D"FONT-SIZE: 13px; FONT-FAMILY:=
 Verdana; COLOR: rgb(99,143,193)"><span style=3D"COLOR: rgb(0,0,0)">DE-8907=
3 Ulm</span></span></td></tr>=0A=
  <tr style=3D"COLOR: rgb(99,143,193)">=0A=
    <td style=3D"border-width: 2px 0px; font-size: 10pt; border-top-style: =
solid; border-color: rgb(99, 143, 193); font-family: Arial; width: 153.71px=
; border-bottom-style: solid; color: rgb(99, 143, 193); text-align: center;=
 background-color: rgb(99, 143, 193);" valign=3D"middle" data-preserved-bac=
kground-color=3D"null" class=3D""><span style=3D"FONT-SIZE: 16px; FONT-FAMI=
LY: Verdana; COLOR: rgb(255,255,255); TEXT-ALIGN: center; BACKGROUND-COLOR:=
 rgb(99,143,193)"><span style=3D"FONT-SIZE: 10pt"><span style=3D"FONT-SIZE:=
 11pt">FOLGE =0A=
      UNS:</span></span></span></td>=0A=
    <td style=3D"border-width: 2px 0px; font-size: 10pt; border-top-style: =
solid; border-color: rgb(99, 143, 193); font-family: Arial; width: 76.2894p=
x; border-bottom-style: solid; text-align: center;" valign=3D"middle" data-=
preserved-background-color=3D"null" class=3D""><a title=3D"" href=3D"https:=
//de-de.facebook.com/toowoxx"><img id=3D"0.h6m20wiz3li" style=3D"" border=
=3D"0" src=3D"cid:facebook-min_80a01dfe-43c3-4373-a597-c4fa143a8352.png"></=
a></td>=0A=
    <td style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 10pt; BORDER-TOP: rgb(9=
9,143,193) 2px solid; FONT-FAMILY: Arial; BORDER-RIGHT-WIDTH: 0px; WIDTH: 6=
7px; BORDER-BOTTOM: rgb(99,143,193) 2px solid; BORDER-LEFT-COLOR: rgb(99,14=
3,193); COLOR: rgb(99,143,193); TEXT-ALIGN: center; BORDER-RIGHT-COLOR: rgb=
(99,143,193)" valign=3D"middle" data-preserved-background-color=3D"null"><a=
 title=3D"" href=3D"https://twitter.com/toowoxx?lang=3Dde"><img id=3D"0.k77=
3m4v9m3l" style=3D"" border=3D"0" src=3D"cid:twitter-min_b2b87642-f9c4-4dbd=
-be0d-25e87273c9a0.png"></a><br></td>=0A=
    <td style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 10pt; BORDER-TOP: rgb(9=
9,143,193) 2px solid; FONT-FAMILY: Arial; BORDER-RIGHT-WIDTH: 0px; WIDTH: 6=
7px; BORDER-BOTTOM: rgb(99,143,193) 2px solid; BORDER-LEFT-COLOR: rgb(99,14=
3,193); TEXT-ALIGN: center; BORDER-RIGHT-COLOR: rgb(99,143,193)" valign=3D"=
middle" data-preserved-background-color=3D"null"><a title=3D"" href=3D"http=
s://www.instagram.com/toowoxx/?hl=3Dde"><img id=3D"0.2pgnn719k03" style=3D"=
" border=3D"0" src=3D"cid:instagram-min_c8b3f7e6-0b92-486c-bde1-1bb9a7160db=
0.png"></a></td>=0A=
    <td style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 10pt; BORDER-TOP: rgb(9=
9,143,193) 2px solid; FONT-FAMILY: Arial; BORDER-RIGHT-WIDTH: 0px; WIDTH: 6=
7px; BORDER-BOTTOM: rgb(99,143,193) 2px solid; BORDER-LEFT-COLOR: rgb(99,14=
3,193); TEXT-ALIGN: center; BORDER-RIGHT-COLOR: rgb(99,143,193)" valign=3D"=
middle" data-preserved-background-color=3D"null"><a title=3D"" href=3D"http=
s://de.linkedin.com/company/toowoxx-it-gmbh"><img id=3D"0.sse7zo5p0nr" styl=
e=3D"aspect-ratio: 236 / 204;" border=3D"0" src=3D"cid:linkedin-min_c300cc7=
3-f06d-4cfc-90c7-f1130e8f3817.png"></a></td></tr>=0A=
  <tr style=3D"COLOR: rgb(99,143,193)">=0A=
    <td style=3D"font-size: 10pt; font-family: Arial; width: 431px; color: =
rgb(99, 143, 193); padding: 10px 0px 0px;" valign=3D"top" colspan=3D"5"><sp=
an style=3D"FONT-SIZE: 7px; FONT-FAMILY: Verdana, sans-serif; COLOR: rgb(99=
,143,193)"><span style=3D"FONT-SIZE: 7pt; COLOR: rgb(99,143,193)"><span sty=
le=3D"FONT-SIZE: 8pt; COLOR: rgb(99,143,193)"><span style=3D"FONT-SIZE: 7pt=
; COLOR: rgb(99,143,193)"><span style=3D"COLOR: rgb(156,159,163)">Firmensit=
z:&nbsp; &nbsp; &nbsp; &nbsp; =0A=
      &nbsp; &nbsp; &nbsp; &nbsp;Toowoxx IT GmbH, Krumbacher Stra&#xDF;e 1,=
 86489 =0A=
      Deisenhausen</span></span></span></span><br style=3D"FONT-SIZE: 7pt; =
COLOR: rgb(156,159,163)"></span><span style=3D"FONT-SIZE: 7pt; COLOR: rgb(1=
56,159,163)"><span style=3D"FONT-FAMILY: Verdana; COLOR: rgb(156,159,163)">=
Gesch&#xE4;ftsf&#xFC;hrer:&nbsp; =0A=
      &nbsp; &nbsp; &nbsp;Christian Thoma, Oliver Wiemer, J&#xFC;rgen =0A=
      Mayer</span></span><br style=3D"FONT-SIZE: 7pt; FONT-FAMILY: Verdana;=
 COLOR: rgb(156,159,163)"><span style=3D"FONT-SIZE: 7pt; FONT-FAMILY: Verda=
na; COLOR: rgb(156,159,163)">Handelsregister:&nbsp; =0A=
      &nbsp; &nbsp; &nbsp;Amtsgericht Memmingen HRB 13224</span><br style=
=3D"FONT-SIZE: 7pt; FONT-FAMILY: Verdana; COLOR: rgb(156,159,163)"><span st=
yle=3D"FONT-SIZE: 7pt; COLOR: rgb(99,143,193)"><span style=3D"COLOR: rgb(99=
,143,193)"><span style=3D"FONT-SIZE: 8pt; COLOR: rgb(99,143,193)"><span sty=
le=3D"FONT-SIZE: 7pt; COLOR: rgb(99,143,193)"><span style=3D"FONT-FAMILY: V=
erdana; COLOR: rgb(99,143,193)"><span style=3D"COLOR: rgb(156,159,163)">Ums=
atzsteuer ID:&nbsp; &nbsp; &nbsp; =0A=
      DE258706918</span></span></span></span></span></span><span style=3D"f=
ont-size: 7pt;"><span style=3D"font-family: Verdana;"><span style=3D"color:=
 rgb(156, 159, 163);"><br></span></span></span><span style=3D"FONT-SIZE: 7p=
t; COLOR: rgb(99,143,193)"><span style=3D"COLOR: rgb(99,143,193)"><span sty=
le=3D"FONT-SIZE: 8pt; COLOR: rgb(99,143,193)"><span style=3D"FONT-SIZE: 7pt=
; COLOR: rgb(99,143,193)"><span style=3D"FONT-FAMILY: Verdana; COLOR: rgb(9=
9,143,193)"><span style=3D"COLOR: rgb(156,159,163)"><br></span></span></spa=
n></span></span></span></td></tr></tbody></table><p></p><p style=3D"margin:=
 0.1pt;"><span style=3D"font-size:11.0pt;font-family:&quot;Aptos&quot;,sans=
-serif;=0A=
mso-fareast-font-family:Aptos;mso-fareast-theme-font:minor-latin;mso-bidi-f=
ont-family:=0A=
Aptos;mso-ligatures:standardcontextual;mso-ansi-language:DE;mso-fareast-lan=
guage:=0A=
EN-US;mso-bidi-language:AR-SA"><a href=3D"https://www.toowoxx.de/passkeys/"=
 title=3D"https://www.toowoxx.de/passkeys/"><span style=3D"color: rgb(70, 1=
20, 134); text-decoration-line: none;"><!--[if gte vml 1]><v:shapetype id=
=3D"_x0000_t75"=0A=
 coordsize=3D"21600,21600" o:spt=3D"75" o:preferrelative=3D"t" path=3D"m@4@=
5l@4@11@9@11@9@5xe"=0A=
 filled=3D"f" stroked=3D"f">=0A=
 <v:stroke joinstyle=3D"miter"/>=0A=
 <v:formulas>=0A=
  <v:f eqn=3D"if lineDrawn pixelLineWidth 0"/>=0A=
  <v:f eqn=3D"sum @0 1 0"/>=0A=
  <v:f eqn=3D"sum 0 0 @1"/>=0A=
  <v:f eqn=3D"prod @2 1 2"/>=0A=
  <v:f eqn=3D"prod @3 21600 pixelWidth"/>=0A=
  <v:f eqn=3D"prod @3 21600 pixelHeight"/>=0A=
  <v:f eqn=3D"sum @0 0 1"/>=0A=
  <v:f eqn=3D"prod @6 1 2"/>=0A=
  <v:f eqn=3D"prod @7 21600 pixelWidth"/>=0A=
  <v:f eqn=3D"sum @8 21600 0"/>=0A=
  <v:f eqn=3D"prod @7 21600 pixelHeight"/>=0A=
  <v:f eqn=3D"sum @10 21600 0"/>=0A=
 </v:formulas>=0A=
 <v:path o:extrusionok=3D"f" gradientshapeok=3D"t" o:connecttype=3D"rect"/>=
=0A=
 <o:lock v:ext=3D"edit" aspectratio=3D"t"/>=0A=
</v:shapetype><v:shape id=3D"_x0030_.3zycwi3oqx" o:spid=3D"_x0000_i1025" ty=
pe=3D"#_x0000_t75"=0A=
 alt=3D"Footer  TOOWOXXPasskey.png" href=3D"https://www.toowoxx.de/passkeys=
/"=0A=
 title=3D"&quot;https://www.toowoxx.de/passkeys/&quot;" style=3D'width:325.=
5pt;=0A=
 height:94.5pt' o:button=3D"t">=0A=
 <v:imagedata src=3D"clip_image001.png"=0A=
  o:href=3D"cid:footertoowoxxpasskey_3d6cf03f-ffa1-48dd-925f-2b1a6883c66d.p=
ng"/>=0A=
</v:shape><![endif]--><!--[if !vml]--><a href=3D"https://www.toowoxx.de/pas=
skeys/" title=3D"https://www.toowoxx.de/passkeys/"><img border=3D"0" width=
=3D"434" height=3D"126" src=3D"data:image/png;base64,R0lGODdhsgF+AHcAACH+Gl=
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3D=
=3D" style=3D"height:126px;width:434px" alt=3D"Footer  TOOWOXXPasskey.png" =
v:shapes=3D"_x0030_.3zycwi3oqx" id=3D"0.g681zju500s"></a><!--[endif]--></sp=
an></a></span></p><p style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; COLOR: r=
gb(99,143,193)">=0A=
</p></body>
</html>

--_f3865e20-426a-4c61-9f60-e0715bf05adf_
Content-Description: logo-min_9a509263-93aa-4c90-952e-cf3ad1644cc3.png
Content-Type: image/png;
	name="logo-min_9a509263-93aa-4c90-952e-cf3ad1644cc3.png"
Content-Disposition: inline;
	filename="logo-min_9a509263-93aa-4c90-952e-cf3ad1644cc3.png"
Content-Transfer-Encoding: base64
Content-ID: <logo-min_9a509263-93aa-4c90-952e-cf3ad1644cc3.png>

iVBORw0KGgoAAAANSUhEUgAAALMAAABVCAMAAAA11yVeAAAABGdBTUEAALGPC/xhBQAAAAFzUkdC
AK7OHOkAAADzUExURUdwTP///////////9fi7f////z8/v////L1+f////////////z9/v//////
//////////////////////T19vDx8f////////////////////////7+/v///97h5f//////////
//r7++jp6////////7m6u9fX2LKys5i0zliItISmxn+AgcHCwsbV456foGaRulqJtVqJtXqfwmCN
uFyLtqvC2LrM3u3u8GCNt9Xf6GqUu9HT1Y2ty9Pg7IODhP///1iItC0tLjAwMV5eYDo6PEZGR09P
UI6PkM3NzpeXmFVWV21ub3l6e4aGh1aHtKioqXOBTekAAABIdFJOUwDzycMJzw79A/jh2xaz1unu
qiW7/v4wUmwdX0eid/47gIn+/ZGZ/v7+/er9/v79/S3GofZPdf775f68/eifK+T//////////sio
GjAAABPUSURBVGje1JgJV+LKFoWFDGSCTEwhCUmAYEtrKwhPxL7vhklQnP7/r3n7VEBxwtZ1113P
WgokVMJXu87Zpyp7e19uUhDlW+W9b9WcyPTysfa9mGMvNu2a9K2gg9j0TNN6jJVvQW9F+bzd2kDz
30Nxx7NNO3a+FfOeyxH0yzyUGP4mVjTn/2swUhDbec7n10prKZ0TiHTEp+I7Zf5fQXlURvqol1jl
bC602JG0Dg9JfLyMwP8dmZ+YNfF9V0hPiVGW4+wajyM+sN4dKS9+Ef3zl0n862uldb6RsqK454I5
m41DlESnbPGS4+AqLSiLWqViPQ3etb7GvGusfH8w6J/wHw9Yknhe4zdD4qXABrKgqtlq4IYtlwd3
JWx5cQvmXbOsDba4fWtJe563ksh/QeeTbmc8Hnd6/R0BI204LZdP78WL4G8VOEHRdTmjFziu5bqu
LyhCVlAUVc2bec99A4fm57liX4icPhFT6wykD8NFLLsOz4D/W3G0wDc5QzYymYycy8m6qiq6oet4
wZmMoQix9Y8nIUt+rTvetE7/wyu0ml+puFbwV697+tcojkJBzslEmJFlXVGguW4wdMPI6Irp/tNm
R/4kOf3xU+uefHSBVvG8qDU6PUfv+/MDDnS5FBrxoSiMWikUiF1HgHC2T8YtvelAfNn5Ivlgi3nc
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
hcJbHPIdbPFfa8syjVCqJbQAAAAASUVORK5CYII=

--_f3865e20-426a-4c61-9f60-e0715bf05adf_
Content-Description: facebook-min_80a01dfe-43c3-4373-a597-c4fa143a8352.png
Content-Type: image/png;
	name="facebook-min_80a01dfe-43c3-4373-a597-c4fa143a8352.png"
Content-Disposition: inline;
	filename="facebook-min_80a01dfe-43c3-4373-a597-c4fa143a8352.png"
Content-Transfer-Encoding: base64
Content-ID: <facebook-min_80a01dfe-43c3-4373-a597-c4fa143a8352.png>

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

--_f3865e20-426a-4c61-9f60-e0715bf05adf_
Content-Description: twitter-min_b2b87642-f9c4-4dbd-be0d-25e87273c9a0.png
Content-Type: image/png;
	name="twitter-min_b2b87642-f9c4-4dbd-be0d-25e87273c9a0.png"
Content-Disposition: inline;
	filename="twitter-min_b2b87642-f9c4-4dbd-be0d-25e87273c9a0.png"
Content-Transfer-Encoding: base64
Content-ID: <twitter-min_b2b87642-f9c4-4dbd-be0d-25e87273c9a0.png>

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

--_f3865e20-426a-4c61-9f60-e0715bf05adf_
Content-Description: instagram-min_c8b3f7e6-0b92-486c-bde1-1bb9a7160db0.png
Content-Type: image/png;
	name="instagram-min_c8b3f7e6-0b92-486c-bde1-1bb9a7160db0.png"
Content-Disposition: inline;
	filename="instagram-min_c8b3f7e6-0b92-486c-bde1-1bb9a7160db0.png"
Content-Transfer-Encoding: base64
Content-ID: <instagram-min_c8b3f7e6-0b92-486c-bde1-1bb9a7160db0.png>

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

--_f3865e20-426a-4c61-9f60-e0715bf05adf_
Content-Description: linkedin-min_c300cc73-f06d-4cfc-90c7-f1130e8f3817.png
Content-Type: image/png;
	name="linkedin-min_c300cc73-f06d-4cfc-90c7-f1130e8f3817.png"
Content-Disposition: inline;
	filename="linkedin-min_c300cc73-f06d-4cfc-90c7-f1130e8f3817.png"
Content-Transfer-Encoding: base64
Content-ID: <linkedin-min_c300cc73-f06d-4cfc-90c7-f1130e8f3817.png>

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
gg==

--_f3865e20-426a-4c61-9f60-e0715bf05adf_--
