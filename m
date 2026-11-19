Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ADA60A380E
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=pwtWHyQO;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=pwtWHyQO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11071125D7;
	Thu, 19 Nov 2026 15:47:31 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4445D10E5A6
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:47:13 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=G0fscsTYoul/BYVAqs+QfhIDKKhPYagJpDS7Iz4GNQujpw+0zc4+6XhhmGWnSVC7ST5GRYMZcP/63XsQaWIrxS7UrFiTIibk4EelU3KfFw4OQ1yOlpId/dyq2ioaGk3Jhd5WRVOmUcHwUk8DcLqPSzdGGEA3b0GKjT+T24OJSIPYUrWfC4sU9uNNsdgyIijQ5XLToADMal4IZaLxopQ7iJMW1JndnOWgqFf9oEzvAjEweLIyfevxeiM8tUQ/8pNJKdI1gNKlQLIY16mgnXieCtNMKVVMNIG2Yg2AU7JLdfW8f4GNRm35q8TeH0wvqMVC0BDCqFcyG44upe6bCLsu+A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiAMRBc54TrsgAvoYqOrFBzmXevP3VmfnTYOgaKe/Ps=;
 b=cgV5on2xna1j/GUajV4pDwuYt9OllluEqVFp7IFcOXOWOI8ByTPTzrW1Sm/H3MCantNV2/ygoB/tUxWVOF3YixPve20xZ4mDtIj/+lpfn0ZVAOeLuDsR9A3kadOpkLG9GgZkfY3i60jetM3xx2Bwlm73VoKiyo280Uo9qVDzi03wdYOR3e7tWKOa7dOaFloY7trJir5zHvhte35ddk/A3+moerFr3YWYs3WbAYtm67eKu4IhgmeMuSu5gl2TTG5TOUVUunOm5IId+Ebjssv+ZK5rGPMDwbHjXNf8jjZE2HvFZ4+Ms0CWKpdbgIDkVs8/3K2IjCSiOGZI28SCuse51A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiAMRBc54TrsgAvoYqOrFBzmXevP3VmfnTYOgaKe/Ps=;
 b=pwtWHyQOVOAMraDlx/3E2K0EQRtiqJoIDR7UUJ9ET7gt650meZ3WBsbDdGHUaxMcV6/WacKIcW9duIyna+xBgUKoIJDOEGbMHtjs3ysaUevbGNVDNDe15xiYzJVSzkTz3FpEoB5uhl0A/FFTNrV40CpDaY0wWCI+8hQFiV8hxDc=
Received: from FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:9d::13)
 by AS4PR08MB7783.eurprd08.prod.outlook.com (2603:10a6:20b:517::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:47:05 +0000
Received: from MI3PEPF0000848A.eurprd02.prod.outlook.com
 (2603:10a6:d10:9d:cafe::26) by FR2P281CA0120.outlook.office365.com
 (2603:10a6:d10:9d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.2 via Frontend Transport; Thu, 19
 Nov 2026 15:47:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000848A.mail.protection.outlook.com (10.167.240.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 15:47:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvhbF06pI4PXdsSUWh9KeJVEo997ZFbA7vqaxc4bJV2oHjOe8S4mLC5zFKPTjmu5E7paoTsLNNHoYSJG2ixXFCB1vxwy6Qt3Dtchp2SSWyBRD3w639WlXw5ePB7QPzoSrmSoAv3u3ZXDovXU95vTMLpMbFoiUknzh/UV3UwQZCOElaS0dRLB4+jZoAeLjUueuOsa1q0TWVYXtNXZeoq0qUeqF7j+yWBaS5+Kquok003eQqSMTikZUA9gdPnnHUxbHbWRNeQYhV+ChCUOL2I9D3n5M2MhSyda4MrjGDYtX23AlXJunYaLI24ZXGdUptwRyvMxcMGed4ih2VdQbO8xOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiAMRBc54TrsgAvoYqOrFBzmXevP3VmfnTYOgaKe/Ps=;
 b=oHd9jq1pE5xsGM59wAogvGQck+tr+UlZg7lvEjHpECAGmnDhD8amgAmUVjxDT6tNbF1Hc96b1TaFYCNAOW2OTBGIKl/VucSHDnnOGri4pkiW9ULQAUtW+5SlAiTNOugOpHg8KFFLTh+S1l9Ye4wEgUXK/hYIIb0ytS+IGzHIHo8MqvtHGvX/tOt6Tjpcseef2XNemT72jt6JtrCYpd2LAPayEYF7W/GRMjvaj9VS4XZUOfLLPFl+vmLxAJyjAN0/Wy4MDeItSvM/gyeiQDX2z4sqvcdXUdg67cv+dTQL8BTy36yEvvbwNG2hM5Oe/mrLsEA9YLfDAGxo+39Tv3oCxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiAMRBc54TrsgAvoYqOrFBzmXevP3VmfnTYOgaKe/Ps=;
 b=pwtWHyQOVOAMraDlx/3E2K0EQRtiqJoIDR7UUJ9ET7gt650meZ3WBsbDdGHUaxMcV6/WacKIcW9duIyna+xBgUKoIJDOEGbMHtjs3ysaUevbGNVDNDe15xiYzJVSzkTz3FpEoB5uhl0A/FFTNrV40CpDaY0wWCI+8hQFiV8hxDc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB10630.eurprd08.prod.outlook.com
 (2603:10a6:800:209::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:46:30 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:46:30 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v4 5/9] drm/panthor: Move register base offsets to the HW
 description
Date: Thu, 19 Nov 2026 15:45:55 +0000
Message-ID: <20261119154604.2519184-6-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119154604.2519184-1-karunika.choo@arm.com>
References: <20261119154604.2519184-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0183.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::8) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB10630:EE_|MI3PEPF0000848A:EE_|AS4PR08MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3c2a64-264e-43be-db1e-08df46545c2f
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|6133799003|261009223027099003|56012099006|260925022911599003|11063799006|261028144727099003|261022075727099003|260925021311599003|260925021911599003|261021121427099003|261022105027099003|261102123227099003|261021123027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: LpQvnxyyEclayhyRNuhSoLDkRCRXInjmIbBMY51nee7ZtonRdak6uGeyExcq2DwPc30w0X2KMiAoSWRQGxVIeuXM3Zfvp/R2h+0IPprHIc9QF2hhfu7nQzeGW8MQPSnFNK/ONA8OEqUMHc+zukl7LdgADSLqs3cRhn8bzU3icblpArRbeslV8I7o5AgFGY/kTvFcxKv/8GmQUXeJoUge/4zLXARazN8EnY+QeqjWoar0DU2zfot/Sc7dlE79h5+qFnyLSLqr8t5q8zZBA2Y6fiEn+845/9FgxkEntiBuNpBBfS8MM9zerTuoY0DgA9H0UYUueR158759adSp2b2oI63INPvjugnYv4+15t5/XRRtBy5bhf4b4nSkz0Q0kB89gpTKeogmccNIP4dNy4Wpn/uqQsqSaw7I+pL8pLNr9VaVDNFWMVAxIhqBiJRL6wpCXhcH+7C9fin7dqmjVG4dO5WOEN7LOomtSxfvUZ/Xas4+0mmG+g8fYPNLEYk64UizxJuhnBEkKqkNppO2FEVx+19vZGwdWhpIV3jbX2oSDRhGIvduxgCqNeEQsg1TAVTS0D8CLLSQ18BvsBepuz8FUCP8lx9btTvPPldR5B+9pjt3BOzGbf/wIMkub7nVYdZAOOe4/ZQNGFxFW4PjqlOMBqR6SqDUMzj7jdIB+H3uuHY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(260925022911599003)(11063799006)(261028144727099003)(261022075727099003)(260925021311599003)(260925021911599003)(261021121427099003)(261022105027099003)(261102123227099003)(261021123027099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: DjhYFQV8hSvDB2HHqVpQZ4/gE0QZr/SF/zjQxBckv/nk5BeOZ0czTEIun7yQpNmrESW9X2TZVuZWhxk6slOOyKHLv38XP3LQ5ZJp9R+rNaZJOrQrhBRO1FGndgkx6CFkHkslR8vUhTaWrA+D2nxFfpPCY1c+aKIjuUx6QQlQvd48xDsYx/7uwfla9uOwz1C/odBIE8T5bLqGk7mYByG1zPLqQ4WUrJFj6Q+meos3MV+212Bwo4u/2DQ05A5mNNGdhC17qC3e/C9YFMkDWs11TE0Cfx69oag57TscwXrj9NkqflVdB/t8UZFpt1FZ6roG8I0G8QNF1DsNyMeGv0lbNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10630
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000848A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 23e19a1f-d3b2-4de3-b246-08df465447b9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|35042699022|376014|14060799003|36860700016|82310400026|1800799024|261026140227099003|260925022911599003|260925021311599003|260925021911599003|11063799006|56012099006|261028144727099003|10067099003|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: NvcS/kitZ2O8HvHEpVvvrtFJpQDjHOxxWfbWq6m7trtPqrHwK/FCO4j7erCsFgK13cuPRMxlVzwwkAnHHbFaVtBNuITVP/HqJE3AQ89XEQU698gCxdw/AzwH9RKBx/IiShwsznSJKdbm5XzlGguUCA3sVmxMKsWFy2prN8XHJl2Kw5Td03btBwkteMgGy8SiLdLbTCQsndWjWJGzfyocgelW9hhyiaaGlsb/wdZSP+t36nwZp/dKaHRXVJNsZdWlWvCCf17mzv6P8B2NwqacB/dtYE9NV6azoTH+Q7IwSaS1KlXT4HoB49lzC+lfpxKpn3c5zKkjGEeH+3FF9t9StSbb2MjZsoAw2okMPO9ifTOQYTguW9HlQ/KQyhCyjuaLC5om3UEUCxTSN37z+Uujy6o9cuP1ri50NRct4f6Bh4xCxyNBVC062v4rylI2We4I5sKD9z0uLdg5665EjbarlpoMQ5vn5LU7H7LYMOqoxq/9hdG6w03WyDRlATjBeHoY9oe7hGfNvNhpvhAfiNvPTniBZz4PVhGlRJ5+sFOgU6SzauhyoglLVkeAGcNvXCDqyCD/Vc+E1EbYyFfO5TuiC1MRwML09gqsG3NHeVhxmk3AL/Qz2QdCZQpXlZbXLtzHopFsOWvhedpQVQwBU87jRaaczKVLA5uVZck5ZxeUFLBw/XUEsagDHSAlptxHpyJhqsb844jK9pxgApOzEte12A==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(35042699022)(376014)(14060799003)(36860700016)(82310400026)(1800799024)(261026140227099003)(260925022911599003)(260925021311599003)(260925021911599003)(11063799006)(56012099006)(261028144727099003)(10067099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6zPpfawDt4s776qvU9t/Qp6NheyFzdFRyU83LfJNubx9ePS10QsRtGrWpKl1xABvpB7ORPrKNFO8qy+rzM3jvkdurQRgXKGXjprV3koEcuFUafG02RFPWWDMGCAMhxNSyFSG6bmH4ejeCi8uAQ7YOZpuj1POCjGu6gShIf4ak8p0o1YRQ/ev0dCajTgsE2f8T6ekUl4kRA4+X/ETN4QIgwHP/mRHFvWZ29GS8aEhjPy5YmkEAA8LF9jMEC8XBQHmtYauh/LIbDuu6A3daE+YMUnzX0ScLGSQwAO2aVtFlcmk75q9v67q+OGMEejOJPB9DRz2ejo2ydGSTHA9mhWUdx5FzCgsazUoG1BVkye3gtmVgcq2w8p4WCwCez+zJy6CVbcU44mMmLyVQELDMRFRK2X42OL4B/Rv789oVI0WHYIpu5MI6o11MbVfUwwk3Iwl
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:47:04.5723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3c2a64-264e-43be-db1e-08df46545c2f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000848A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7783
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

Mali v15 reorders several register regions, including GPU_CONTROL,
MCU_CONTROL and PWR_CONTROL, so the driver can no longer assume a single
fixed base layout across all supported GPUs.

Add per-GPU register base offsets to the panthor hardware description
and switch the GPU, FW and PWR local iomem setup to use those stored
values. With the base addresses now owned by the hardware description,
drop the corresponding fixed base-offset definitions from the register
headers.

This prepares the driver for GPUs with different register layouts
without changing the existing behaviour on currently supported parts.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v4:
- Picked up R-b from Boris
v2:
- Picked up R-b from Liviu
v1:
- rebased on drm-misc-next
- use a generic panthor_hw_regbank structure for all register offsets.

 drivers/gpu/drm/panthor/panthor_fw.c       |  2 +-
 drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 --
 drivers/gpu/drm/panthor/panthor_gpu.c      |  4 +--
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |  2 --
 drivers/gpu/drm/panthor/panthor_hw.c       | 23 +++++++++++++++--
 drivers/gpu/drm/panthor/panthor_hw.h       | 29 ++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_pwr.c      |  2 +-
 drivers/gpu/drm/panthor/panthor_pwr_regs.h |  2 --
 8 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 13efed3a2ea72..679ea1d233d53 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1500,7 +1500,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
 	if (!fw)
 		return -ENOMEM;
 
-	fw->iomem = ptdev->iomem + MCU_CONTROL_BASE;
+	fw->iomem = ptdev->iomem + ptdev->hw->regs.mcu_control.offset;
 	ptdev->fw = fw;
 	init_waitqueue_head(&fw->req_waitqueue);
 	INIT_LIST_HEAD(&fw->sections);
diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
index b2e59cfc22b00..a3492f7f913f9 100644
--- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
@@ -4,8 +4,6 @@
 #ifndef __PANTHOR_FW_REGS_H__
 #define __PANTHOR_FW_REGS_H__
 
-#define MCU_CONTROL_BASE				0x700
-
 #define MCU_CONTROL					0x0
 #define   MCU_CONTROL_ENABLE				1
 #define   MCU_CONTROL_AUTO				2
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index c5c37f22993d6..ab54119314da0 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -159,7 +159,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 	if (!gpu)
 		return -ENOMEM;
 
-	gpu->iomem = ptdev->iomem + GPU_CONTROL_BASE;
+	gpu->iomem = ptdev->iomem + ptdev->hw->regs.gpu_control.offset;
 	spin_lock_init(&gpu->reqs_lock);
 	init_waitqueue_head(&gpu->reqs_acked);
 	mutex_init(&gpu->cache_flush_lock);
@@ -176,7 +176,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 		return irq;
 
 	ret = panthor_irq_request(ptdev, &ptdev->gpu->irq, irq,
-				  ptdev->iomem + GPU_INT_BASE, "gpu",
+				  gpu->iomem + GPU_INT_BASE, "gpu",
 				  panthor_gpu_irq_threaded_handler);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index c7581b6d4c5be..60819c4ace428 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -4,8 +4,6 @@
 #ifndef __PANTHOR_GPU_REGS_H__
 #define __PANTHOR_GPU_REGS_H__
 
-#define GPU_CONTROL_BASE				0x0
-
 #define GPU_ID						0x0
 #define   GPU_ARCH_MAJOR(x)				((x) >> 28)
 #define   GPU_ARCH_MINOR(x)				(((x) & GENMASK(27, 24)) >> 24)
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 854874a9f322a..4fe9e6aeadf76 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -36,6 +36,14 @@ static struct panthor_hw panthor_hw_arch_v10 = {
 		.power_changed_off = panthor_gpu_power_changed_off,
 		.power_changed_on = panthor_gpu_power_changed_on,
 	},
+	.regs = {
+		.gpu_control = {
+			.offset = 0x0,
+		},
+		.mcu_control = {
+			.offset = 0x700,
+		},
+	},
 };
 
 static struct panthor_hw panthor_hw_arch_v14 = {
@@ -44,6 +52,17 @@ static struct panthor_hw panthor_hw_arch_v14 = {
 		.l2_power_off = panthor_pwr_l2_power_off,
 		.l2_power_on = panthor_pwr_l2_power_on,
 	},
+	.regs = {
+		.gpu_control = {
+			.offset = 0x0,
+		},
+		.mcu_control = {
+			.offset = 0x700,
+		},
+		.pwr_control = {
+			.offset = 0x800,
+		},
+	},
 };
 
 static struct panthor_hw_entry panthor_hw_match[] = {
@@ -195,7 +214,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
-	void __iomem *gpu_iomem = ptdev->iomem + GPU_CONTROL_BASE;
+	void __iomem *gpu_iomem = ptdev->iomem + ptdev->hw->regs.gpu_control.offset;
 
 	ptdev->gpu_info.csf_id = gpu_read(gpu_iomem, GPU_CSF_ID);
 	ptdev->gpu_info.gpu_rev = gpu_read(gpu_iomem, GPU_REVID);
@@ -221,7 +240,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 	ptdev->gpu_info.gpu_features = gpu_read64(gpu_iomem, GPU_FEATURES);
 
 	if (panthor_hw_has_pwr_ctrl(ptdev)) {
-		void __iomem *pwr_iomem = gpu_iomem + PWR_CONTROL_BASE;
+		void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
 
 		/* Introduced in arch 14.x */
 		ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index c4a490bc39de6..0a82152d772ad 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -27,14 +27,39 @@ struct panthor_hw_ops {
 	void (*power_changed_off)(struct panthor_device *ptdev);
 };
 
+/** struct panthor_hw_regbank - Register offset and instance stride information */
+struct panthor_hw_regbank {
+	/** @offset: Register offset relative to &struct panthor_device.iomem */
+	u32 offset;
+
+	/**
+	 * @stride: Register offset between instances, or 0 for non-instanced
+	 * registers
+	 */
+	u32 stride;
+};
+
+/** struct panthor_hw_regs_layout - Hardware register bank layout */
+struct panthor_hw_regs_layout {
+	/** @gpu_control: GPU_CONTROL register bank layout */
+	struct panthor_hw_regbank gpu_control;
+
+	/** @pwr_control: PWR_CONTROL register bank layout */
+	struct panthor_hw_regbank pwr_control;
+
+	/** @mcu_control: MCU_CONTROL register bank layout */
+	struct panthor_hw_regbank mcu_control;
+};
+
 /**
  * struct panthor_hw - GPU specific register mapping and functions
  */
 struct panthor_hw {
-	/** @features: Bitmap containing panthor_hw_feature */
-
 	/** @ops: Panthor HW specific operations */
 	struct panthor_hw_ops ops;
+
+	/** @regs: Hardware register bank layout */
+	struct panthor_hw_regs_layout regs;
 };
 
 int panthor_hw_init(struct panthor_device *ptdev);
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index b1000001325ea..1cfd4b658c81b 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -502,7 +502,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 	if (!pwr)
 		return -ENOMEM;
 
-	pwr->iomem = ptdev->iomem + PWR_CONTROL_BASE;
+	pwr->iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
 	spin_lock_init(&pwr->reqs_lock);
 	init_waitqueue_head(&pwr->reqs_acked);
 	ptdev->pwr = pwr;
diff --git a/drivers/gpu/drm/panthor/panthor_pwr_regs.h b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
index 80d8e1e522298..e1f3153285bd7 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
@@ -4,8 +4,6 @@
 #ifndef __PANTHOR_PWR_REGS_H__
 #define __PANTHOR_PWR_REGS_H__
 
-#define PWR_CONTROL_BASE				0x800
-
 #define PWR_INT_BASE					0x0
 #define   PWR_IRQ_POWER_CHANGED_SINGLE			BIT(0)
 #define   PWR_IRQ_POWER_CHANGED_ALL			BIT(1)
-- 
2.43.0

