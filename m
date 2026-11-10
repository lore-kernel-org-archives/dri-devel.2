Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F333606D74F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PVO5tYAc;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PVO5tYAc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9982310F7D2;
	Tue, 10 Nov 2026 15:42:27 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0010510F7C1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:42:16 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JFfSNke8B+zCCmxEuJFocpqceXyU16OX8aVNuYbuy1i+/Ijpp6wrZGX62JdM8m9LpVWXZQqCI+irSVvPKe9et0rFUGdPrtT+5vE0nP9C8VGCMicoARY5WiwS+1NAxtLE7hahb6j2iOiZ2j7VEaSjxz5KlJGeX7ipbqCauvYi7eN/kPvtMkKWbPGFnTZhfysskPm22bCEHt3ER4aTK7aDcMkESkPD7gSoKnZHv9zh9zLuXWq4FfAd4KJGA+bUx073JN1oOfuX2Wa2tR1C7Oiv1Ltkwq6piQj/a2Qww3iIDebmUBK5YfsVjIubzzkv4NGAWw+hljplG5b5AhChP62rzg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmc5+jHijOmD78lCxx7IGSqSiEEgGBwxZNx+n+M+doE=;
 b=xx96vlpHkkIT8EqP2QbVp+oD7OVSOyV06xdWn+DWd8hY7/2xebvvP0QfIZaG35t7VkzSdoLCYGDGjHZHKiX3Jas5w+r0PXojAhxD+77jcV3B9+hLk3t/4kCWKdyRNEHboWp9w4xWXTv/9ZuqAfSctdJHKcPXTk0I92zxXX7wOC+7qGTaHjpF/0/nOnYVcmX6PkegUvB1Gr+vEBLfUiQizIuAJNO++RnltE3VHt0wEa6vdU0mbPoby5pD9eBPr1jyZaFEuzirl7MOHcWs9VMmHTS3327ccb8rqDrrPxa7rtqmPvMwcMV1VumDLx3J6JVAu3YpE9ROeK4UjoxD9ZkdKg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmc5+jHijOmD78lCxx7IGSqSiEEgGBwxZNx+n+M+doE=;
 b=PVO5tYAcZRc+jXRWqZwJP74qcxXiHNsU4bpD5JMaJUW1QkhaVIuvHYdd3PIG6DhU7dhDYxNihQwTJ0ZHsrwKEAujTpMdhSVmL8qw0jBDTmGa+MbqqCsaS8zoU4wwcCsCorDfhSKqB20kJUeQiqIaGvVxfXo4RCqmUPfQ/KVLWvs=
Received: from PAZP264CA0229.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:238::11)
 by VE1PR08MB5790.eurprd08.prod.outlook.com (2603:10a6:800:1a9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:42:09 +0000
Received: from MI3PEPF0000848D.eurprd03.prod.outlook.com
 (2603:10a6:102:238:cafe::47) by PAZP264CA0229.outlook.office365.com
 (2603:10a6:102:238::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:42:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000848D.mail.protection.outlook.com (10.167.240.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUCLGcmFyuIfUzBDa5tlg8cbGhhZTej8hMUeh9E0NXBiW11RR/WXHWcmYYcnrx4dojbaTeYtTEAQh0fi9z+1RfvLsTh08g0MTcZyDy0D0cKPaCH3Y7ZvZ7qHX0VcllJ7opWnA1Ui9DxcSKxjqWoGhIbe3wg58Ph0J4VVGtKZjLpA11zS60psEhch4PMM+QGZFDQ01ps5B3z+2x4vLkKdaWLROFYotsxs7nTBWbYgriTdWQp6PI3ao3K9G2jnbpLlXaLFLEihksPUrgaQzH0DJdkojk8kSXh6v2Wee+3ArAKavEYwiFEDXTyFjjEqFm1l0D80yo5BPXpjpypGTZgc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmc5+jHijOmD78lCxx7IGSqSiEEgGBwxZNx+n+M+doE=;
 b=sfHJS4AfFD1ndC9OQdBuf1sFQ1XuplfyeDczmMwmmSijrtU9NP4v262x4KZFbgu0jr234spM059E8/RUWdzemH6hJY6v9m/NRF1aj96tfp7yj/Vy84kDZxiwmqNqUV3HD9i+5UhQEXrycGq/6rh0+8VGNrGHdBHIivxCzO9Z1CjNOTnKawl0qrFqidPcT0bMBQHufmvkNr/rlYaMfmaJ6TteXbGfz12YaY5/YuY9RQ9PvwNoSf5oyVahYFspqtCV6Zi64psB3nFnCFbP5OlNDwGKwl7DQKyZZw5WfXwXzAik3s5DMWgVwVnqm/Pt2AuD5GpeAICLa6cGP0tslcgieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmc5+jHijOmD78lCxx7IGSqSiEEgGBwxZNx+n+M+doE=;
 b=PVO5tYAcZRc+jXRWqZwJP74qcxXiHNsU4bpD5JMaJUW1QkhaVIuvHYdd3PIG6DhU7dhDYxNihQwTJ0ZHsrwKEAujTpMdhSVmL8qw0jBDTmGa+MbqqCsaS8zoU4wwcCsCorDfhSKqB20kJUeQiqIaGvVxfXo4RCqmUPfQ/KVLWvs=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB11064.eurprd08.prod.outlook.com
 (2603:10a6:800:252::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:41:35 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:41:35 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 26/28] drm/panthor: Tolerate access-window loss during HW
 waits
Date: Tue, 10 Nov 2026 15:38:47 +0000
Message-ID: <20261110153907.3241978-27-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0120.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::7) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB11064:EE_|MI3PEPF0000848D:EE_|VE1PR08MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 8374798e-4452-407d-793b-08df3f412ded
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003|6133799003|3023799007|10067099003|261009223027099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: wJ5cV2L2oHDPLlcGR/JAUzusYrS4v41iyFDI/IBdG9F/s1D5YlGWWTIY6Vf/IRMdUNXafkzX6gt5uVu0S0+pwqkhvXt1t1svZY0AJCjO7/+0AY0x9Bidq0gTaPFdkWH30tgLcRUZ9MNB+yD3k7L5Bjy5Y6viINs6TnNUXeRN5KNO9BbUSMm2BAOfUapgsna5sCQmJirR10Z0u2ddKZU8578vH+Z9N/a92iXF27wrk4/f4zE3PpPOaIk/xEwIckLXCbg5zNhuJvizIJIfFJWW4ZhZPRMmWxmY2a6jGXArcRj+Y8X2C0xBJ2slxY1qa2AUyNDeOzc4kJYuPSELG0wgpqnWIflbMYBqfi9RldaY/khjlGndv9d7wUTDAU40ARGILHOTjnHtj86Yu9j/58DquAmmI56yKpEM3ju9uBntYknNfPi0IFVP8Zwa9/2e6oC+HAymGgiqiUc2+S8XPdrHjn5deeDNopPFrM/155rlxm3j9LJVlRGdys3BSmU8te/GAakuBlgCp0/NnB7rTozIxzmzFXYVpl8JOCyEXYVoCRztXUUkizOQ+mM/OQSysQMLRayDBZbq7zvj5pK+x/mOl9xf+sgDRUptBjCPU4QsZymA7+gUWCstUWovwyX4RUVMvQBFXibPu/vKQv5CoGKyKSGMYTslxAYZ1bO80PREKCQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003)(261009223027099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261021123027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: oX0krA5t2tw1tk8FDaFyusQ/0rUMKOwTwCGCvxSyMYQBXZU/5mvYDL+qekRwPn/EOR+plhMLGtESe/XFb3OSKk7NqyvOJj74wi+OsgDKOgPPysVTqr0vfzaXKyJ/l8vXG5f2rMCa596mSfxqEoHZ4Rp5yKqp8Pu9933D7Wyi4V2pPIGlCuQ+6YZ5lIU+9F2qbIK7QdeIH2tXAr3u3TRu9O8Vnh7FF5TVhRJsxNp32RLBhj7T7zzLyHSzorEw7ffOzJK5s0L5KbxgF/VNujpyJX3cE35rWlJWslBC1cQNIpvO/cxF2boS3IMl081hsP6qEGAVUP6GpxDN+cU20/cM0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11064
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000848D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 93676708-88f4-4ef3-7611-08df3f411a3e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|23010399003|1800799024|36860700016|14060799003|82310400026|11063799006|261022075727099003|56012099006|261021121427099003|261021123027099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: NC/30dAEhbZfAlg6FZDUeoQmvLdfVR/vAS8eysfQX2tG3Ak6fOoV8dfacwzSHKTPZZv58Z4kDbt+5wax0jJyHrgw/YcJhOo6JADplxc2JF5od3iqdr+SvqPXgLK59ww0Vv6zRqzna6IKkhqxJyjius3KjWGcEoWjhS3ZGtYW608mfVZNaleCfhvGw4PXIRop22/JihEJLOwm4hhNDFe4kGE+AekjR4iVjwNFZaGI0YH/Y8kpErArI0e0YK0zmVork1gT/7AkfrwLHo4DvgaHP9JXd6bMI4ysAkXQna1roBV6jW+rwtv9lO7GJLqtSnDINrQL5iJp3r2MBdj24lbzXlLnaFCAqHjVPZlnDRSCb2fB0vkYdLguAvL4GT6qaX83yJmI9GAdMjW/4fgmmY/4vw5oPdvgvtg6KGDQJjioohAH01cD3Xed4bTDNq59enXka3svcLgl3UjbapZimUj+uaw6uBtHkb2YrE+io/j49asOJzMHObMPP0pCuNPICwa8iwV5TuDR+3qX7bSY1ZK3fv9IDBkUu2QjlGsuUhUlnylTAccBt+q3rcCDfjM0tT7lFDegbeRKwYJKFTNZ1/QEe4dB4Qn8c6mKjNkxIuq+zNDLwNOdxK5Lv3D3vbNvGLqbziBSritxL39q45CWVxfKWgQcM02SBMQwRdPPHjrDzrDFlAisL1yYO7KemZOcvklGzoRKmzx0SCl5BKbeId+P7Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(23010399003)(1800799024)(36860700016)(14060799003)(82310400026)(11063799006)(261022075727099003)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6BDXa/CShJ6jznc0zOtZOK8Kch9ZXrE+ZKuf/LA0KMl6FGob/dihXBfxFPSzZ1sdRxWCrbfFkOKW6nZFP9ckMir9w/CCEoyczsFpKREdwg1vXpiw/8/QWRapoGrMeXuty++gMS6JIxDBqsVPjXJW2Di6WQIY64bptK/rRcz31JCsS5hXENP7XfjtwZjLpJ73AS+cohsDm1b+2s4BfRfcEwDRQFpcAn4lsfJQWrlz+Vldl+G2qWK4qVC8+MYB3aC0WtggPNVRVEpS1bYe0vzucvvTom4rua/tFxhSVEw2cwcMMimw0OlzZc8joiRGDlXxO+79Es+DbeE3fJKh8P0ORIDGR2Knd/g8I06exayTzgyc5ZVq5mDSrTJhwjeZa/bdWWVTcNA1IVrgT4c1Qx0tSYVZLfvwVyg27hfePqRz3xC2WrlfWZlmcNgj74eTCZiv
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:42:08.3675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8374798e-4452-407d-793b-08df3f412ded
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000848D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5790
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An access window can close while Panthor waits for a cache flush,
power transition or firmware boot. After access loss, these
operations may not report completion.

Add a helper to check whether the access window has GPU access.
Suppress timeout errors in cache-flush and power-control waits
after access loss. Allow firmware boot and MCU halt waits to end
when GPU access is lost.

Wake firmware waiters from the access-window interrupt handler.
Publish the firmware pointer after initializing its wait queue.

Skip scheduler processing of firmware events while GPU access
is unavailable.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Notify FW waitqueue on WINDOW_CLOSED to make waiters re-evaluate
  state instead of waiting until timeout.
- Use smp_store_release() and smp_load_acquire() to ensure waitqueue
  initialization is visible to the AW-close handler before it attempts
  to wake the waitqueue.
- Bail early on MCU halt wait.

 drivers/gpu/drm/panthor/panthor_aw.c    |  9 +++++++++
 drivers/gpu/drm/panthor/panthor_aw.h    |  2 ++
 drivers/gpu/drm/panthor/panthor_fw.c    | 20 +++++++++++++++---
 drivers/gpu/drm/panthor/panthor_fw.h    |  2 ++
 drivers/gpu/drm/panthor/panthor_gpu.c   |  4 +++-
 drivers/gpu/drm/panthor/panthor_pwr.c   | 27 +++++++++++++++++++------
 drivers/gpu/drm/panthor/panthor_sched.c |  3 +++
 7 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panthor/panthor_aw.c
index 3b418c816d824..f344a2aa32979 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.c
+++ b/drivers/gpu/drm/panthor/panthor_aw.c
@@ -340,6 +340,7 @@ static irqreturn_t panthor_aw_irq_raw_hander(int irq, void *data)
 	if (status & WINDOW_IRQ_WINDOW_OPENED)
 		panthor_aw_handle_window_opened(aw);
 
+	panthor_fw_notify_waitqueue(ptdev);
 	gpu_write(pirq->iomem, INT_CLEAR, status);
 
 	return IRQ_HANDLED;
@@ -630,3 +631,11 @@ int panthor_aw_ensure_gpu_access(struct panthor_device *ptdev)
 
 	goto again;
 }
+
+bool panthor_aw_has_gpu_access(struct panthor_device *ptdev)
+{
+	if (!ptdev->aw)
+		return true;
+
+	return (atomic_read(&ptdev->aw->state) == PANTHOR_AW_STATE_GPU_GRANTED);
+}
diff --git a/drivers/gpu/drm/panthor/panthor_aw.h b/drivers/gpu/drm/panthor/panthor_aw.h
index d1f43c4ba17e5..29b32f3d810fd 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.h
+++ b/drivers/gpu/drm/panthor/panthor_aw.h
@@ -45,4 +45,6 @@ int panthor_aw_wait_transition_complete(struct panthor_device *ptdev);
 
 int panthor_aw_ensure_gpu_access(struct panthor_device *ptdev);
 
+bool panthor_aw_has_gpu_access(struct panthor_device *ptdev);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 1449d9a66302e..8643e7bbfc108 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1140,9 +1140,10 @@ static int panthor_fw_start(struct panthor_device *ptdev)
 	gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
 
 	if (!wait_event_timeout(ptdev->fw->req_waitqueue,
-				ptdev->fw->booted,
+				(ptdev->fw->booted ||
+				 !panthor_aw_has_gpu_access(ptdev)),
 				msecs_to_jiffies(1000))) {
-		if (!ptdev->fw->booted &&
+		if (!ptdev->fw->booted && panthor_aw_has_gpu_access(ptdev) &&
 		    !(gpu_read(fw->irq.iomem, INT_STAT) & JOB_INT_GLOBAL_IF))
 			timedout = true;
 	}
@@ -1180,6 +1181,9 @@ static bool panthor_fw_mcu_halted(struct panthor_device *ptdev)
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 	bool halted;
 
+	if (!panthor_aw_has_gpu_access(ptdev))
+		return true;
+
 	halted = gpu_read(ptdev->fw->iomem, MCU_STATUS) == MCU_STATUS_HALT;
 
 	if (panthor_fw_has_glb_state(ptdev))
@@ -1223,6 +1227,16 @@ static void panthor_fw_mcu_set_active(struct panthor_device *ptdev)
 		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
 }
 
+void panthor_fw_notify_waitqueue(struct panthor_device *ptdev)
+{
+	struct panthor_fw *fw = smp_load_acquire(&ptdev->fw);
+
+	if (!fw)
+		return;
+
+	wake_up_all(&fw->req_waitqueue);
+}
+
 /**
  * panthor_fw_pre_reset() - Call before a reset.
  * @ptdev: Device.
@@ -1501,10 +1515,10 @@ int panthor_fw_init(struct panthor_device *ptdev)
 		return -ENOMEM;
 
 	fw->iomem = ptdev->iomem + ptdev->hw->regs.mcu_control.offset;
-	ptdev->fw = fw;
 	init_waitqueue_head(&fw->req_waitqueue);
 	INIT_LIST_HEAD(&fw->sections);
 	INIT_DELAYED_WORK(&fw->watchdog.ping_work, panthor_fw_ping_work);
+	smp_store_release(&ptdev->fw, fw);
 
 	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "job");
 	if (irq <= 0)
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index a99a9b6f4825c..c1c6fb9b7b7d6 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -513,6 +513,8 @@ panthor_fw_alloc_suspend_buf_mem(struct panthor_device *ptdev, size_t size);
 
 struct panthor_vm *panthor_fw_vm(struct panthor_device *ptdev);
 
+void panthor_fw_notify_waitqueue(struct panthor_device *ptdev);
+
 void panthor_fw_pre_reset(struct panthor_device *ptdev, bool on_hang);
 int panthor_fw_post_reset(struct panthor_device *ptdev);
 
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 2e1b00e86cdea..d5666264c1fe6 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -18,6 +18,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 
+#include "panthor_aw.h"
 #include "panthor_device.h"
 #include "panthor_gpu.h"
 #include "panthor_gpu_regs.h"
@@ -377,7 +378,8 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 				msecs_to_jiffies(100))) {
 		scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
 			if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
-			    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
+			    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) &
+			      GPU_IRQ_CLEAN_CACHES_COMPLETED) && panthor_aw_has_gpu_access(ptdev))
 				ret = -ETIMEDOUT;
 			else
 				ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index 1cfd4b658c81b..66a2c54b070dc 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -10,6 +10,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 
+#include "panthor_aw.h"
 #include "panthor_device.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
@@ -122,7 +123,8 @@ static int panthor_pwr_reset(struct panthor_device *ptdev, u32 reset_cmd)
 				msecs_to_jiffies(PWR_RESET_TIMEOUT_MS))) {
 		guard(spinlock_irqsave)(&ptdev->pwr->reqs_lock);
 
-		if (reset_pending(ptdev) && !reset_irq_raised(ptdev)) {
+		if (reset_pending(ptdev) && !reset_irq_raised(ptdev) &&
+		    panthor_aw_has_gpu_access(ptdev)) {
 			drm_err(&ptdev->base, "RESET timed out (0x%x)", reset_cmd);
 			return -ETIMEDOUT;
 		}
@@ -279,9 +281,14 @@ static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd,
 
 	panthor_pwr_write_command(ptdev, pwr_cmd, mask);
 
-	ret = gpu_read64_poll_timeout(pwr->iomem, ready_reg, val, (mask & val) == expected_val,
+	ret = gpu_read64_poll_timeout(pwr->iomem, ready_reg, val,
+				      ((mask & val) == expected_val ||
+				       !panthor_aw_has_gpu_access(ptdev)),
 				      100, timeout_us);
 	if (ret) {
+		if (!panthor_aw_has_gpu_access(ptdev))
+			return 0;
+
 		drm_err(&ptdev->base,
 			"timeout waiting on %s power domain transition, cmd(0x%x), arg(0x%llx)",
 			get_domain_name(domain), pwr_cmd, mask);
@@ -343,9 +350,13 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
 	 * allow-flag will be set with delegated-flag being cleared.
 	 */
 	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
-				      ((delegated_mask | allow_mask) & val) == allow_mask, 10,
-				      PWR_TRANSITION_TIMEOUT_US);
+				      (((delegated_mask | allow_mask) & val) == allow_mask ||
+				       !panthor_aw_has_gpu_access(ptdev)),
+				      10, PWR_TRANSITION_TIMEOUT_US);
 	if (ret) {
+		if (!panthor_aw_has_gpu_access(ptdev))
+			return 0;
+
 		drm_err(&ptdev->base, "Retracting %s domain timeout, cmd(0x%x)",
 			get_domain_name(domain), pwr_cmd);
 		return ret;
@@ -400,9 +411,13 @@ static int delegate_domain(struct panthor_device *ptdev, u32 domain)
 	 * allow-flag will be cleared with delegated-flag being set.
 	 */
 	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
-				      ((delegated_mask | allow_mask) & val) == delegated_mask,
+				      (((delegated_mask | allow_mask) & val) == delegated_mask ||
+				       !panthor_aw_has_gpu_access(ptdev)),
 				      10, PWR_TRANSITION_TIMEOUT_US);
 	if (ret) {
+		if (!panthor_aw_has_gpu_access(ptdev))
+			return 0;
+
 		drm_err(&ptdev->base, "Delegating %s domain timeout, cmd(0x%x)",
 			get_domain_name(domain), pwr_cmd);
 		return ret;
@@ -542,7 +557,7 @@ void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
 	const bool has_neural = panthor_hw_has_neural(ptdev);
 
 	/* Abort if L2 power off constraints are not satisfied */
-	if (!(pwr_status & l2_allow_mask)) {
+	if (!(pwr_status & l2_allow_mask) && panthor_aw_has_gpu_access(ptdev)) {
 		drm_warn(&ptdev->base, "Power off L2 domain not allowed");
 		return;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 729eeb339fa40..addc5986554df 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1887,6 +1887,9 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
 
 	guard(spinlock)(&ptdev->scheduler->events_lock);
 
+	if (!panthor_aw_has_gpu_access(ptdev))
+		return;
+
 	if (events & JOB_INT_GLOBAL_IF) {
 		sched_process_global_irq_locked(ptdev);
 		events &= ~JOB_INT_GLOBAL_IF;
-- 
2.43.0

