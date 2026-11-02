Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7C8606B0E5
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=KWINS2i0;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=KWINS2i0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A91B10E011;
	Mon,  2 Nov 2026 16:33:06 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72F010E011
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 16:32:54 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oMpanH9KgkHM7yn0mMLQdHymGw1q7Ei/sfXgxMtSd4Slt3quVc0z9x6szQ+UPCAOcDAjuDIQCSMTgyUIWlPpaS0bdP+aF6K4kwEyFlRF4ukeTRokhOCdAnO4gz88g1Z1GQ+7M6QsT8PJ7cKNZ5nwejdvfTsKaIiNNuIZmB+cBITiCV51nQ+YEBIjGFgYQ4aihfqez2OSpHEPdBrAkOUxUtTitmNZKQm9CGhU+vY1QV3tDjuC3Yc9myQYmOa0RZtgMcMD8dQqIjJYn/Vd7v1WRxNLCxOVMruyuLHHnvZ4IbHnjokdOnLrlwRC6JgnFt9DDH4vq3w95PXu0M0di0vEjA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc+4nehyxRqd2JiB/tGrOxARAIvOE9jB8xqqFick27E=;
 b=RKCbeJyUYOd7l5Kw4Bee7KFuuCyuNkVIduTwIbTHeRLoGNILUpRiqbgHzlH0ZxZiiZL7Zpi5svkw2oC8xuv5OCOP+kQvWb7/r/ln9N/sZSRU6k2ZBATcpcEGZ7ZOzDFueJfUwk31sjJaexSom9xvZSPB6WYgFnhBJrZ4Vz1c7NtRjZmbaylteTJgQcISbV0F73sTXhJLfjOwJoaKPfLod9G6Q4628maNsjxk2xT+kFvq9Jt4J0z9V7s9OplJ3XIEUkQtRdbLBf1P19+lMZV+25sRMWzinxM6HovvnsRPLl4CzbDG2UpAen5jS5hhI7EnI1fVeh4grg/sHpxRtiowUw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc+4nehyxRqd2JiB/tGrOxARAIvOE9jB8xqqFick27E=;
 b=KWINS2i04PDf7SZmumljL7e8wiI0yxsLveZb47u0POHFAwpHx9PsBQGbyW4vmnXOfDcxcUBbPIgU7x2m/LBu6YZ3S7UySmPs33o+OOwTLaf6TplVt0lxuPTsJkQQJkXN41jANfa8BxgGSG1vWtGUCi16AKqobvw5mcH+QO6uG80=
Received: from PAZP264CA0196.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:237::7)
 by DU2PR08MB7344.eurprd08.prod.outlook.com (2603:10a6:10:2f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:32:46 +0000
Received: from MI3PEPF0000847F.eurprd02.prod.outlook.com
 (2603:10a6:102:237:cafe::5f) by PAZP264CA0196.outlook.office365.com
 (2603:10a6:102:237::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 16:32:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000847F.mail.protection.outlook.com (10.167.240.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 16:32:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6j0BSGsjg/m7cQqZRTr5BOyL+Tz9y3nGhhRtrJMW4M+wK/o/svedwgo5YianCElez9/1/7vbEQHB3y5JJaiBHHd8yYszUBINIZRSPwdQt3hMmFDgO1zBmMQMD/FOprmV5NmeTmINlrrephnpSMwCT+8ajKJ23P8yCSGAqfihiVArXJT521RLVLYaL0zr5VBD2OaN1gZNpZ1iFToJhFFGgW8IZgE9XX/PaMWUA3AVt4bRL8JunTPm28UyNf1gpsLAL8LRd7IEBAu8f+hysBg9YDwQvXMdcaZt4Oy0ygk/65Qg5nz1t6n/Ym1csIV68qFr0jkVATMEoeupHkDlUYAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc+4nehyxRqd2JiB/tGrOxARAIvOE9jB8xqqFick27E=;
 b=dsaqlPN1ycRTjbZxS9lcDOUdFYFM5IroJ7pwec1YTxCs/7oyt74uwzWPWK55FA5rEdcpNecB+3G0trQLAnHDc3eMwtCU9DfMbyUSVqsTFWiNAIIpeuB6HpvlsYqzklm7PqV6WiI7XIDtx0ZOGjVc4PZC1tCjuVOdHc/+/Kgm0QhHnnDRveJDi/HB+8/N0KBawRpPmRhrekGpCknLaObZZHEKvY6TvTnySKgA2WIFvZNNaBP/TbEOIX8BeOeCUe9T2FoKHId26qMz8Zju6QuuKtqFz6ESnZwEiVaB2YLmdL0EqUOBhsi4iB7A1a6n2L6EBobrmw49qzEtZwRE0LJPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc+4nehyxRqd2JiB/tGrOxARAIvOE9jB8xqqFick27E=;
 b=KWINS2i04PDf7SZmumljL7e8wiI0yxsLveZb47u0POHFAwpHx9PsBQGbyW4vmnXOfDcxcUBbPIgU7x2m/LBu6YZ3S7UySmPs33o+OOwTLaf6TplVt0lxuPTsJkQQJkXN41jANfa8BxgGSG1vWtGUCi16AKqobvw5mcH+QO6uG80=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by MI9PR08MB479607.eurprd08.prod.outlook.com
 (2603:10a6:290:c1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:32:13 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 16:32:13 +0000
Message-ID: <b6d505ca-53cc-4d93-b049-3d97c5b4e7f7@arm.com>
Date: Mon, 2 Nov 2026 16:32:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: Add more reviewers
Content-Language: en-GB
To: Liviu Dudau <liviu.dudau@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akash Goel <akash.goel@arm.com>, Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Florent Tomasin <florent.tomasin@arm.com>,
 Daniel Stone <daniels@collabora.com>
References: <20261030144305.666845-1-liviu.dudau@arm.com>
 <20261030144805.667158-1-liviu.dudau@arm.com>
In-Reply-To: <20261030144805.667158-1-liviu.dudau@arm.com>
From: Karunika Choo <karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0105.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::20) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|MI9PR08MB479607:EE_|MI3PEPF0000847F:EE_|DU2PR08MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 52abe95a-b373-404f-e55e-08df38feed53
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|261102123227099003|56012099006|11063799006|4143699003|261022075727099003|261026140227099003|261021121427099003|261026121527099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: 2LH18v+Nnhri5NE67S2xwccMsEl366rULq69IpKMIkSyMhjqKm90wTk/Iuj5dFl3y0pc6x1sCCHu+Qw6zvoEEwLFxVwQEzDGxLyAajJZu1sDz+3bJv6H2UdhNwbcsQ+1pLK+4QxB1UKGCOh/0OfQmx2nC0zckmXm/3iKnbgOMpDVLveE0Gk0j0iJ+tJTxu0R/quz6WuM/25MqVAjRTc4uzWnx1j5M+mw7FocRaaJWXrgP9SuECgMbGxKp9syvBz9Nd8GhbyWRV5e55D+a397WQyy26qRoHVshYT/8EBYTvRfNkOs/hSV3qMUSmZvx8JuOBe49FNTgzUVzVJLO/wX299SlAfBCg7gmy9ijjAfNY5PlJMujpH0H+/I2dj85exBKmzmwigfzgswVA0EFuW5p2zL4CNMF6BZ+PVb/2TZ5i+s+X7NuGI4SeT4EspAW0YIqeYElFTPSc03JhLTmbGDr/zjDeITheVVx9oScN6tGYO+YsbYxa++uBc95ompmUOJCyTrJADdalZLs2f+TF3Fjm1qd0SYyFOrEaQvnPxSBU55eDB5nD9yoIzf3n54cP6ZUpuZfA93F//rvXKhJOqdz+WSidnvNvfHH8X+FsBmW+s=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(261102123227099003)(56012099006)(11063799006)(4143699003)(261022075727099003)(261026140227099003)(261021121427099003)(261026121527099003)(261022105027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: eDCN5Nk+gpSgYkRFFncoXvDnuqAgRUHsmKIdOlk3uKu3dxsOmvQ5utfCrPOlu9s/YKcumGGcJRk/Vn5dWE6PzAtk6V09wkCzfMvjRO8Ea9RK3WC7WKL/PG7FtFAFxwZPMXiDZY3qM07sGg5aA+zCBA9UHQ/gk8XtiGCiq5+McRBM4yom0cFClQ7mnVNnoQ28OPuKye/YJ4uPsolIhE3f9zEKdJuWGS3eFhlrDKSrIC8bfLrecZeVzmIHQiAkHFDHkl3ewvtASSD3OMo1NE7UyMJIcArbk+TpyMzQc9poZc8jjmuUybVgmemSPowaS9Okz/zmQ2stXRN7dOcMxghOrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB479607
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000847F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9f9a2069-d102-425a-88fc-08df38fed977
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700016|82310400026|35042699022|376014|23010399003|1800799024|10067099003|22082099003|261102123227099003|18002099003|13003099007|56012099006|11063799006|4143699003|261022105027099003|261021121427099003|261022075727099003|261026140227099003|261026121527099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: xVPDAD2ZouaQ6voVT+sxGWCqIB4Hryx7xyxjBljoXk+7YvxlR3ke3pwVRwCEQ3JGoiPfYJZlRQgnSbDvHC5zsLIvAJB5i/byXSKE8AdWdVWXO/EF3/I7vLg1pyuGNycHtjVWBiYJbM4j1zqttYfr2i4fWMHZt24pdx/dMncgmhI6qXheyNq5GhAiSn8qtxY5Pkz4LegGIoOP+VzPVA92ptLe7mFu44rbHRqtG2a4nd9gacc7IVMcQDWHa7wrS7joviEnqf5VzUqluUVQNeY54XvfQT2xSZI9cA06WwSVsyeg1+/KQWulF+9Rl7GZQW1rCk+TU4fLGJa3Lfpxanm7E5XdeBIJqTICEe+tBrGD4a2CQpNMopLWnY7MctwAc9iq9YL/m/Hq2GVHAJr8e/Ov9O+ezBbCjFgSDr+68aWozr45ubOoUAXBNQyO1rAn+XMfTc1Ch/hLnvVwYBxyKeWChBQDhYpuzKELGfpIScoqIhnya+6BxgKdi0EYTEDyQoifOFSki6SUnwtVLTbbn17SKvo34aTl2EuxG23EQl04rd3HILm8lyyu5iPD3zQ8TqneB7y5IhIAbannJt2tPAz0WFafWCPtuZBT0zGaxVb9s6o7TnAJG3cStilLdz/25e1SKGfPeQF0vzlWINhDFThECg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700016)(82310400026)(35042699022)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(13003099007)(56012099006)(11063799006)(4143699003)(261022105027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261026121527099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5v59rG+7iYNCmyi9DQQl+AXaw+QLEgTiqLMskVsneWyXaWl7/QWOB5nl8tac3Nj8RFvdGa3Mld3ikJM985gstYevtCnQUVVH2x7F09aYDHGbzU0TbDIswVcEIwRM4cgJm9gtfBbXisqYV/ulMUSgIWipT+cxeDU/DxRzEFDuDf0Eks9JTbT2y+dFMCtvMsqkKqZk08CEccjFdT+QyrfXxs0YRx6CYSXLZpMVoO7YmEDVfg9xBG2W+SoK0vk9xwg7tOXp/aMPVFsQMfO2y8p55nkrymyQtWBxIhOfbmCgIFdS6/Kh5tDbpNfFK/pCxC3FLqGDPQkthaaFhNy3Vnj7XpvrZ5Kt0BRx6/02d98cOsXErjsKASCnrGZ1xSxOSp91FVlmwH/vH42DenaU9C5g9qj3NV2ZkTdUT7hWS2Kr3ZbtkFbpgr++oIOgylhOGeB5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:32:46.2754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52abe95a-b373-404f-e55e-08df38feed53
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000847F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7344
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 30/10/2026 14:48, Liviu Dudau wrote:
> We now have more people that can do reviews and contribute patches
> to Panthor, so add their names to the list.
> 
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> ---
> v2: Forgot to add Chris Diamand to the list, fixed.
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 89ea35a35c680..ef92c462a8381 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2321,6 +2321,10 @@ ARM MALI PANTHOR DRM DRIVER
>  M:	Boris Brezillon <boris.brezillon@collabora.com>
>  M:	Steven Price <steven.price@arm.com>
>  M:	Liviu Dudau <liviu.dudau@arm.com>
> +R:	Akash Goel <akash.goel@arm.com>
> +R:	Karunika Choo <karunika.choo@arm.com>
> +R:	Lukas Zapolskas <lukas.zapolskas@arm.com>
> +R:	Chris Diamand <chris.diamand@arm.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Supported
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

Acked-by: Karunika Choo <karunika.choo@arm.com>

Kind regards,
Karunika

