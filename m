Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA0606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Xl3xmIPz;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Xl3xmIPz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78EA810E3CA;
	Thu, 26 Nov 2026 16:13:20 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013047.outbound.protection.outlook.com
 [40.107.162.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09C210E3CA
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:13:08 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=YCZ8lRXSKUTYHRCD1oUG4Udih8iWoZNhaUnUpMpLgWSVI9zQUDbxezrTMaq/341DNKXu7iKFX84THpVlgCtSvKQ8oPoC89HWt3+Atb1jpT7jCvK1uEh0qA9ZyZAH/GVNpyLsn8OmXmVqA/iwQrZZeQEODlqoHSXheNkDqcJNziYoAyvGau8WYkyA3f2RocwdDjE4+weEmY48XWtEi1Mk1LGrLgDseE7K2MxYDo4Z5slbufoT/DTr6AP57fUOi/DSVo3f1z3AHu2Vw/mnZThqtpJe+rluuVgWxasomtpcUsEH85slTZKa9cKEfHAJCNA/w7vqyItdV15GeMbFJeDj0w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxBelHF11fMLl6AJ6b88F0PjaW3WA/WUDFA71OKYMXk=;
 b=PUMYACYnswU/RLaZnozVYn9pMPXPJRRqspTUSADeZpxlKn3EXv+tZj9RJeiDlRH+yFC5dNrmivKRarhbjDBiZxL6Ut2TasYal5vPp0Ofp9hzetJjKGpb1uDySn0TRYF2HVyZnWTLglgwKZwXNPJbAP+NDB6Ymj2KnMGSUMw/0IrfJJDMBvfJS5sgHvlZQ/z7CpzDc8zxRarqAZ9M5TzlHVOKkLf8f0w8tns4iG6TJn5tlSP99ZfVvHShn0DqU+n3bC3jvrCl2zvJgI03bgKZ5oJ8tAhN0d5Ad3KSo08tx8tbDlMN7P0cYB0AkfH1TbqjXyqxaZq+BfqXD9d5sH9g+w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxBelHF11fMLl6AJ6b88F0PjaW3WA/WUDFA71OKYMXk=;
 b=Xl3xmIPza/Kv/4TrX+rwuC6obezgXHHskxZVhSGbV/y/7JIcc8zV4johQZjChFXkrNE4xmkVnwUp3yYzEEtJXN7Fima6uCIuFok+bf35rTmXamawxdrpIBf5l7MclitYP/UVukL7Grv/Jfs1JbuOdHvJ6+/n98xSs9MoISDbviQ=
Received: from AS4PR09CA0009.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::12)
 by MA9PR08MB712885.eurprd08.prod.outlook.com (2603:10a6:250:10c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 16:13:04 +0000
Received: from CPH1EPF0000052A.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::21) by AS4PR09CA0009.outlook.office365.com
 (2603:10a6:20b:5e0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 16:13:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF0000052A.mail.protection.outlook.com (10.167.241.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5
 via Frontend Transport; Thu, 26 Nov 2026 16:13:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5mVl37u0hoVNvMj1aWdiyhq7f1rxd9G5JJiIUCeNvWmBzP1FPOREeHqdFEkWUk6sQHaU0BPLdV3BKmDYt1+Ca4Vy+VRREv6W/cXGvpbmaDbW433LBHGlPLf6YPmIz846mIzFJ63/GFLQn4/NXQShwHtfG4PXLbocxEzOp/K+sg2d7OY6obURWnU1nonXEYttuMbBHuVxWftzvaVmWxmpUb4Nf5HkTpmk6VFhDepA8uKJrHgGCb3j7ggE38sP6ScLydcPnNi4ehcXWEAPl3CwzmLKF3Zt20K9hWH3lzoOoauMs1Qi3bczvJwG/Z7sB274dyhT3WUIuBoz3R8IZ2L/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxBelHF11fMLl6AJ6b88F0PjaW3WA/WUDFA71OKYMXk=;
 b=OK366+vwwftlQy139BYFCk+hI7ONGSaDjH9uSFbnH70B4YEiXGji0o6xdRz2Md5wrlPn92pLje5wPvEn+guuBS26i+pQa9mfdbf29SBvqnOQZjwdJYahVka90vhanoRSKzdWfvvgJx/FPeO6hxU+EKz8AZ/KHY1q/HSxEKMehbNt8B0u679AudvnkxQMHdlx2IMZf6qV5IzYg+tD4qtUgRNzOjHUhX5V2TvaQyuz+QjhGzJryqxuPH4TUrllTJgiOaelmF9oLeoBMVSH5g8X4l8iEcd/0zv91+/bXPA3zk4F0XsY3L73jWrMv1lqVmR9loM2ruNQ1/zFMsYgB3vsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxBelHF11fMLl6AJ6b88F0PjaW3WA/WUDFA71OKYMXk=;
 b=Xl3xmIPza/Kv/4TrX+rwuC6obezgXHHskxZVhSGbV/y/7JIcc8zV4johQZjChFXkrNE4xmkVnwUp3yYzEEtJXN7Fima6uCIuFok+bf35rTmXamawxdrpIBf5l7MclitYP/UVukL7Grv/Jfs1JbuOdHvJ6+/n98xSs9MoISDbviQ=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by VI1PR08MB5520.eurprd08.prod.outlook.com (2603:10a6:803:135::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 16:12:27 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 16:12:26 +0000
Date: Thu, 26 Nov 2026 16:12:24 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Paul Toadere <paul.toadere@arm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>
Subject: Re: [PATCH v2 1/3] drm/panthor: Report the last VM fault through
 VM_GET_STATE
Message-ID: <2mlnebze55diuli27ahhr4eupryodfsr2kpnglgqeyeguz2whl@767mdinbvrs2>
References: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
 <20261104-panthor-fault-info-v2-v2-1-673b31f3840c@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-panthor-fault-info-v2-v2-1-673b31f3840c@igalia.com>
X-ClientProxiedBy: PR1P264CA0184.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344::12) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|VI1PR08MB5520:EE_|CPH1EPF0000052A:EE_|MA9PR08MB712885:EE_
X-MS-Office365-Filtering-Correlation-Id: d51248fa-f859-4c23-2ffb-08df4bd82645
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|11063799006|261022115727099003|261021121427099003|261022105027099003|261028144727099003|261021123027099003|261026140227099003|261102123227099003|261009223027099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info-Original: DzSeVyGgTpH6vzPYvVOuZSm/+d7OmdanIzirNldovR37Dw7BBpue+95ZQoIGwXHQgO9jLNrgvE4Cd0xHh+eZgsCazbvUEG57F1Q/8AKwrGRJnpbC4QcCy868vbWIn0KqR1ULXb5NF7DqPHhunxdcxxhpgbBN4bSBWaYe+1/YuB79gCDkWGmesON/BO4NnYMjytoX63zS7ELriQKvR5uP9t0MuZm4deWiONJk2pkx6Ea5MP6Wmk8MCxJ2r4qY+phvubfIyfTcwjW1mVwRZEH2zkoLEJvt/i/MGsXkR+bPsvcwwp4hSc3ESPpT8JvvklXknafD/8ut8a8btWuq3Gb9mnGw1v3pciyDKqt0MqFiZOiHKZ5MsVF9KAPLIKeXUqXEqDuhDvkydlzRFEsRv9y3pjfavNqtXnUmPX5B7xiq1lGEVxbNw2BUUmSZJrpmhjhhE3ApGVkuNqyxRunsrmp6lAMFMgs8zO/I1fGzxFKhtVUIsEpL3O0eqkg9i2BnE2YnOkXZFdDpUtffrLj1y6eFIAgGNcIcGWnaPhTr/sxsKWMtpbXemxd0D8GIlRWK9efjh34Pe25NyU99Q6nxWSIWrn7A1oGPZ8GfsEc1BY/OPEzLLwCSE7UIlVGa/3c+4XT4
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(261022115727099003)(261021121427099003)(261022105027099003)(261028144727099003)(261021123027099003)(261026140227099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Ns0FrEDzDxkmt8IVZidNQR2fgl9SMnO/5gRNUSM7El6fmau+j7XpT4ode0sZwQi4tJDG7EVbSgqXICc4ogW5F48j8DE14cS67spI+JWrNg6Nj9uGEsqhhsO3+88VvjJBfgjs862gqtIpaYvYgyYBUOm27z/c2RD/IsvWnJraeOm2jbrU1sqal7VwMLzBKPHlMOlaI5JZqufaIbmN9LQ7p5uocthE6x0DbYQbCFCnoi79Pv3KVEa00//RLmuwLTAUwEJhhzAcKxSlTg1yVqFKaF3iRNATsnB13fwDoX9RP2Wvw1OiS2UR4lUn6M+i0ZarSZAHNQD0lAt/qZzIZI62kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5520
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF0000052A.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 87e3c7ca-e51f-491e-8da0-08df4bd80fba
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|35042699022|14060799003|23010399003|376014|7416014|1800799024|4143699003|261009223027099003|22082099003|18002099003|13003099007|11063799006|10067099003|56012099006|261102123227099003|261028144727099003|261022115727099003|261022105027099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: DAbFnTRNx9oUIMNKfX8hKI8z+yDEzlLLcXy4RXByMAcNl1xPQq2X/EC4wC8g5W2uZOnKwUl03C1h76+ju863VQlmOF/1cf5rvbl0Q+BzKdqbnkkjXypT50W52CzBz6tCDJP9cegh2BszhWTNm/qbmVDSAbBIiT4E//mPQ6fL9OX23+8sMA1PnT+hgno+gtNTnaHD/ZSmds7FlY3ILjvPLODPmftiW4NWRDLPIfTpXDwfRuTTLLJ0wYEFdUWcHToHvywDEZQnArlroxWHRqfCa4rNcqaum2WLE1jt+PHG/v9ZwVb/+R4HQ2B/qxVI5O1dyxgTO2iRm/ee8KzuUCijyjiV50f2VEa8OhSdnhzleMqd4x9mXhGzQQ1i3Uc+LWRAMY3R4k5kBiXqTf4T8Bxf38DFqeWoaM3b2bd7BjofwxoshD48ZqVABLaga+vGQTC3L7T0QqI/sVfy8H18wX6inRX75Oa7jIhDM6KFQqqbt7pCqZAltT5sFwWT0MAIOb0PVcAsOvaR4eHJ3yUL9oE3/N9PUd42s8RPjUMYbIWpnqKGxiPqYcVSIP96BItEHhHGfau/3WkWyTmmiCbQbbIE/H2U/sIhrxmFxELezLknzYbIvo2RlX/EALtgGtn4+a/QP50ynOw/A9HBYyPugQa+v8ldj2d9RZGhFOng2O06SIw=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(35042699022)(14060799003)(23010399003)(376014)(7416014)(1800799024)(4143699003)(261009223027099003)(22082099003)(18002099003)(13003099007)(11063799006)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261022115727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ByXwj9KgPm7FC7YYFgL5hzU6qz2iqVCHxO2YYLNoOsXkkY2xBWFoTON1bf40zDThMkougw/h5m3D8FgQSc/SurtrQFBkSm2rsYyZbLLWDohQwahSbIC30snD1Kt5p0BBQu++pAcoJGJFNiUiQBuHrGjWv/tDBrhxtoin5LkzbCYq0WPCS2fNeDarevn/VOMxCZDO8Y3iBUjJpq6nYGmnAwgw09VTmrHpmWXl0Gmp3sIDnQv+yUmL5ECdts3kmrgubwO7b57mpOq1sv4Q8m3W8wRM5+UWNOCzD1p3Odg2N53l/YK1aN65jOnkriiXUugY3gMX83Fg75BjV772KdvzE8Y3Rua2v7Qyf0wFKC3c4/VgPHdiuSGtXBjNgapkuHnnYqGmL3Ad0BRQPNGAYeyYiQ2O2Jf7EFOIaPETSbEFHVtBXomRbXO4ltQg0n8/O87k
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:13:03.5403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d51248fa-f859-4c23-2ffb-08df4bd82645
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000052A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB712885
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Christian,

Sorry for the delay in getting back to you and thank you for progressing
the series.

On Wed, Nov 04, 2026 at 08:52:39AM +0100, Christian Gmeiner wrote:
> From: Christian Gmeiner <cgmeiner@igalia.com>
>
> Keep the raw AS_FAULTSTATUS and AS_FAULTADDRESS of the last fault in
> the VM and return them through VM_GET_STATE. Userspace decodes the
> values. No memory is allocated in the fault path.
>
> The MMU irq handler records the fault under the AS slots lock. The
> ioctl reads it under the same lock. The VM stores the fault as a
> struct drm_panthor_vm_fault, which is the uAPI struct, so the ioctl
> can copy it with one assignment.
>
> The unhandled_fault flag is cleared when the VM is re-activated. The
> stored fault is not. So userspace can still query it after the group
> that hit the fault was killed.
>
> Old userspace that passes the shorter struct still works, the DRM core
> zero-fills the missing tail.
>
> Link: https://lore.kernel.org/r/20251215115457.2137485-4-lukas.zapolskas@arm.com
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c |  2 ++
>  drivers/gpu/drm/panthor/panthor_mmu.c | 33 +++++++++++++++++++++++++++++++--
>  drivers/gpu/drm/panthor/panthor_mmu.h |  2 ++
>  include/uapi/drm/panthor_drm.h        | 22 ++++++++++++++++++++++
>  4 files changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index dc8d0191aef4..7572cd7d6423 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1471,6 +1471,8 @@ static int panthor_ioctl_vm_get_state(struct drm_device *ddev, void *data,
>  	else
>  		args->state = DRM_PANTHOR_VM_STATE_USABLE;
>
> +	panthor_vm_get_fault(vm, &args->fault);
> +
>  	panthor_vm_put(vm);
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index d1c29eec46f2..6fc5f3d381c1 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -389,6 +389,15 @@ struct panthor_vm {
>  	 */
>  	bool unhandled_fault;
>
> +	/**
> +	 * @fault: Last fault on this VM.
> +	 *
> +	 * A new fault overwrites the previous one. Unlike @unhandled_fault,
> +	 * this is not cleared when the VM is re-activated. Protected by
> +	 * panthor_mmu::as::slots_lock.
> +	 */
> +	struct drm_panthor_vm_fault fault;
> +
>  	/** @locked_region: Information about the currently locked region currently. */
>  	struct {
>  		/** @locked_region.start: Start of the locked region. */
> @@ -662,6 +671,19 @@ bool panthor_vm_has_unhandled_faults(struct panthor_vm *vm)
>  	return vm->unhandled_fault;
>  }
>
> +/**
> + * panthor_vm_get_fault() - Get the last fault of a VM
> + * @vm: VM to query.
> + * @fault: Returns the last fault, with a zero status if no fault happened.
> + */
> +void panthor_vm_get_fault(struct panthor_vm *vm, struct drm_panthor_vm_fault *fault)
> +{
> +	struct panthor_device *ptdev = vm->ptdev;
> +
> +	guard(mutex)(&ptdev->mmu->as.slots_lock);
> +	*fault = vm->fault;
> +}
> +
>  /**
>   * panthor_vm_is_unusable() - Check if the VM is still usable
>   * @vm: VM to check.
> @@ -1855,6 +1877,7 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
>  	while (status) {
>  		u32 as = ffs(status | (status >> 16)) - 1;
>  		u32 mask = MMU_INT_AS_FAULT(as);
> +		struct panthor_vm *vm;
>  		u64 addr;
>  		u32 fault_status;
>  		u32 exception_type;
> @@ -1895,8 +1918,14 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
>  		 */
>  		gpu_write(mmu->irq.iomem, INT_CLEAR, mask);
>
> -		if (ptdev->mmu->as.slots[as].vm)
> -			ptdev->mmu->as.slots[as].vm->unhandled_fault = true;
> +		vm = mmu->as.slots[as].vm;
> +		if (vm) {
> +			vm->unhandled_fault = true;
> +			vm->fault = (struct drm_panthor_vm_fault){
> +				.status = fault_status,
> +				.address = addr,
> +			};
> +		}
>
>  		/* Disable the MMU to kill jobs on this AS. */
>  		panthor_mmu_as_disable(ptdev, as);
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
> index abc36e7204be..74f9f5d98c94 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
> @@ -11,6 +11,7 @@
>  struct drm_exec;
>  struct drm_sched_job;
>  struct drm_memory_stats;
> +struct drm_panthor_vm_fault;
>  struct panthor_gem_object;
>  struct panthor_heap_pool;
>  struct panthor_vm;
> @@ -74,6 +75,7 @@ struct panthor_vm *panthor_vm_pool_get_vm(struct panthor_vm_pool *pool, u32 hand
>
>  bool panthor_vm_has_unhandled_faults(struct panthor_vm *vm);
>  bool panthor_vm_is_unusable(struct panthor_vm *vm);
> +void panthor_vm_get_fault(struct panthor_vm *vm, struct drm_panthor_vm_fault *fault);
>
>  /*
>   * PANTHOR_VM_KERNEL_AUTO_VA: Use this magic address when you want the GEM
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index a2ff0f4ec691..85e197d7a528 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -743,6 +743,20 @@ enum drm_panthor_vm_state {
>  	DRM_PANTHOR_VM_STATE_UNUSABLE,
>  };
>
> +/**
> + * struct drm_panthor_vm_fault - Fault information of a VM.
> + */
> +struct drm_panthor_vm_fault {
> +	/** @status: Raw AS_FAULTSTATUS value, zero if no fault happened. */
> +	__u32 status;
> +
> +	/** @pad: Will be zero on return. */
> +	__u32 pad;
> +
> +	/** @address: Raw AS_FAULTADDRESS value, valid if @status is non-zero. */
> +	__u64 address;
> +};
> +
>  /**
>   * struct drm_panthor_vm_get_state - Get VM state.
>   */
> @@ -756,6 +770,14 @@ struct drm_panthor_vm_get_state {
>  	 * Must be one of the enum drm_panthor_vm_state values.
>  	 */
>  	__u32 state;
> +
> +	/**
> +	 * @fault: Last fault on this VM.
> +	 *
> +	 * A new fault overwrites the previous one. It is not cleared when the
> +	 * VM is re-activated or after a GPU reset.
> +	 */
> +	struct drm_panthor_vm_fault fault;
>  };
>
>  /**
>
> --
> 2.56.0
>

Reviewed-by: Lukas Zapolskas <lukas.zapolskas@arm.com>

Kind regards,
Lukas
