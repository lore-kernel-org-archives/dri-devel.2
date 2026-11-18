Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF09606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Y6ZBndN8;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Y6ZBndN8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE5410FEDC;
	Wed, 18 Nov 2026 17:55:05 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE13410FF02
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:54:46 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XBmA+7uabMcZzh/w3qwkL93d83vIxxsIA/SgU1u7KWp2VvpP9aXOXMrKDt01ZRZQBPCqBkuIlv15hlkjWUWuOsQrtmI0dcG0YgSYRd0HXsl9m7MUXchhcnpQSovpv/XxpIsrxtELNFAmbxnBT4OtydXF7K9aJG0RFLt4MQDI71b4ZGNQDxrYN+JKdmm3yGAk637paw6MIcaYhUPbRkLL4lpoKzZ8WwMEyIqPEtj/3N3e+mFiy8iXAaJ0kvr29+RwL05/WEuhaIQ1gIoT0aG1QtfJLhHyeBdEFVFgt+mAAlt+XW+UqJccYcrr70TysIhC4Jlu0R26fUWRV7SfvNOBmg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c/X9vfwlfQAv5N4M1eSE+aP9pe70RNfvfvng8ieImI=;
 b=OibLaoay9ETn/+ACyEH6mUi22a6UQ+IDbVLxkYMFJ22y6MhqQcICjlPzWmdcczUUl1S9NGv6h68Ko0aOVRTgGAzwGnpU8ueaMuU3ardiIxBwRy80+zP0xlRvLBYueCayvnbXes2auym/52+VlrlYMD254DMNC2YBDRYnc+p749+3417uyQv9soxi0aBBJ+0OEeVisVZvkzZ6TOr/j2N16RzJoCEQg4K7yuBl0y031K5gLHm8Mvb/MTLC/OCN5TkNxkIA4GypI3Mg9pu/tMS+S0BuiZkv9yobaS2edSx7gsXN2pnTgRZL79ud99rn+3L/g6Eq+UuL2q2nx+I7RLjU3A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c/X9vfwlfQAv5N4M1eSE+aP9pe70RNfvfvng8ieImI=;
 b=Y6ZBndN8FEAtcsYBAr2nqXopm/EuUhfoVtz/TS2jbgLb3xYg+pjGl2I//ojs3o0OA63WRaKDEajF8g7RHHtAKYKxU09i+o7dHK+ghn3DFrtF4XNttrFIM2PIgHwQR8Tsfj/x0P1ml2rYt5M3bNALivptmxowe6vq/sKF6avD7Cs=
Received: from PA7P264CA0325.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:39a::22)
 by DBAPR08MB5671.eurprd08.prod.outlook.com (2603:10a6:10:1a1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:54:43 +0000
Received: from MAD0EPF000008C7.eurprd05.prod.outlook.com
 (2603:10a6:102:39a:cafe::22) by PA7P264CA0325.outlook.office365.com
 (2603:10a6:102:39a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 17:54:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008C7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 17:54:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHAeT7tiDynkqqOsLROoeLzLBSqisqJwhmbTQz94mTEPMM9HdPMSMoya8vgCCtXU0eE9T/jAnmxZc7kH1pYfPED/qwQ8///Z1MqYxbOnP39YTOCOsBE3ADcqTJNsH5ihH3vb99I+PwXbEK+Uj7tbQJdIS/hGz3OJUdQEPqRmKDmAqAqC7EE1MLyUTg/qU5cpIe8qZ9cgQ/O21ah8wDvUWx7InQKtlWdq0ptRtRJAfLTX0EIP6gk+R7nVjKpVnvmlVr2SbQk+QEnxXZ6GdtvCzK7sOj+9rEWp3uJfc+Md5b/5DgwHM/8BWDTBswg+HZt7f/t0xJstWpxwj991pUMmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c/X9vfwlfQAv5N4M1eSE+aP9pe70RNfvfvng8ieImI=;
 b=bSha+Nrct8vbZfQUwT+U2mAkGJLnKBUBrkT4ExgA7cSeygyz8REqfqoCqKJsH3ha9sBAkmf/LY2LxFFkRUvuPu+fkn4AsnHJx3uZsbYcOelCUO0Ic9LHb984uZ4JDck7fpvIl/hnpclFZHk7/2Uu/mdEHqVqnl0xWzLwFwhb0s3CuhmyfM8X8VLayvCiZJTulddWCUc+YRtz5uE7TtXVuQ5SRK/kEnxtmbP+ipUqOSMIxcj9QX1RuBFas8ac6HP5TR9+WmuWokXBDFm2a5BzcyS7NvL++72/BnlDUPqGlX+qXeY7qb4NHKSfSkclef3xOehS2GlOdFHvUKRoZFKvbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c/X9vfwlfQAv5N4M1eSE+aP9pe70RNfvfvng8ieImI=;
 b=Y6ZBndN8FEAtcsYBAr2nqXopm/EuUhfoVtz/TS2jbgLb3xYg+pjGl2I//ojs3o0OA63WRaKDEajF8g7RHHtAKYKxU09i+o7dHK+ghn3DFrtF4XNttrFIM2PIgHwQR8Tsfj/x0P1ml2rYt5M3bNALivptmxowe6vq/sKF6avD7Cs=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DU0PR08MB7739.eurprd08.prod.outlook.com
 (2603:10a6:10:3bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 17:54:09 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:54:08 +0000
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
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 08/10] dt-bindings: gpu: mali-gen5-am: Add Mali 5th-Gen AM
 schema
Date: Wed, 18 Nov 2026 17:53:24 +0000
Message-ID: <20261118175332.519657-9-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118175332.519657-1-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0074.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::7) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DU0PR08MB7739:EE_|MAD0EPF000008C7:EE_|DBAPR08MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 30758509-31ab-48c5-ff31-08df459d05f5
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|261022105027099003|261022075727099003|10067099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: OgJL/dAbn+WoyZdt/I7KMvM0yu5RlHkhFq/dMxarrZlpWi1sHcKfU47LSLJuDiDCgSmxXbX3mGZ1JiaozFr8R/eyb+KZ59zP72c+aJLWZDG0sl/ud1JwGRfRm/87Ih2EuuyEUfcWD219rSmwlMqm6hIzQYH/M0G4sW8Lo/XyPq7Gw9A+DgckgGxOEhVLW5BWuDRSNM960KtotibGeDMbURDIGXCxFL+E+xNp/HFtXwNLF/xhw1bcSmCIQp4NZpr/phdhu29yIl7GLHwzckjYhTZXbajzpJKjjlDnLxXwsaCdc1+SQ2e4ENTgJ4bInKDFRb/aaSdO8uxsKpDeEmAdOFhgQtTodIt7QwL1RhRLplZ6OzRHqUsy772UD26I+TbTtCBqOFqDh0GD79fDqbVHZ9OTzI4iJwrUi9rHGXLHCIl87bZ0eE+ofrKVH1xnRQFRbOhkifVGBs7hsxdnl1VmfStvhWfiZRI0JBmsJSrDWr8NTM2+72vEmqYF4PR1z1uliamgftAsgQHCC9j1gDuBVI2nmnYMCa4vYE4WdXyTMj+KFpPTKpnmkcNlZGyqJeC6UkOhZ+yXkWGKAulHVGpZqfz1f8nO2NdPT8blbmqKToE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(261022105027099003)(261022075727099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: QyEdkD0n5FZrJFyhBMG0gy0KMUbWYyMn65smldd7wNTqs4DSZ/4Yq5ybJ4gRYbk+mGubA+sMFwQXgxP41MkwaJy6fprTw3BgbRAeSNa5snNj9WK3i0HDl47S7msXtdmq8cGsW/NSxoZ9Fr+2YHuWIEnXUB3l5PJxv09gGWBPb/nKH9ldvoEe5etm0qo711oo10w0REw6MI/ijVIW3mhEmXYZaii85jT6ibMxpzPt0r+UP2UN4VK0p8YBVbrBhDwlFD87NehupL3I9qh3uBJrEtNbH0Xh49carkMwoPxbTi6fQ86kGCFtvZBRbURS4O1AnJ18y+vO8MUKRLiY+BKfSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7739
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008C7.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9372915b-21a7-4b47-604d-08df459cf20d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|23010399003|14060799003|35042699022|22082099003|18002099003|261009223027099003|3023799007|13003099007|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: +c3U10ENM1V8tY16u5d+rrYxGPSraZKqqbVjWvADC7AtGa8D1NpXwWLghZuALjUbK+hpRosqX7BbJh7UJSLRuaypdu0KNtBT4t4UYivF3bfNhKk1OJsfdvC+BKvi1yvLcderdH935SLSPoLC26VKufHD3+sqtGcp81ohp6fRlYu/Dp4gE7MUt15X+CALfiw+u52T3GMDmn8FZ9LeW3Gv9Kkjv3hciDA8OZROJle96iudcIgPQvS/C5Kk53XlRxAXjoBg9eQLemskNuiiR3s0vxlHnk9iYjcupN7GYnotqb1ozLA8DABLSl3EucqHDYe5akwat12ruasxOb43tkEr9Nyr0JrDBFiRifvvCEQTGtvfjxS33sKmFal+90Z1iU1wXG34yvBEYPmzACS2ruJkDuro22GUskWgpLvPYdXEBXETW/E0zXWT3WYbO2olqro3Non3xXBaxtp9qn0o2YVg3Zxu2RKeAjl9dmD95PrXfXvS0Wi8NGediickExj6CuIJybLLrrHYfWasy6ZPKWjSwOMniqDxFK7L1gqGNqsuG/l+8uujmI6Lb0QSHe/uFYCAs3kZCHRClHU3+iEs9H7/Vbh3E2/xUFRiHPu21EA+ffjRfN5JyuAui0TDL0zdwvXXg1GmwumfcmoTDBbdCf8YRg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(23010399003)(14060799003)(35042699022)(22082099003)(18002099003)(261009223027099003)(3023799007)(13003099007)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ibzHWvCDKA4vzbWBdR4L3qvV2RvgUnLXNnvNA0zrBZzlJiN7O2BdOlrf9QeopHa2QexgErR1MTrnVMSLa6yqn45ecLSU7Y19CNRGry5h95gnWOAsAVCYI2p5FAKbuDGlNzUKnTN7DZeQkbUfmTVh2jFEZ4X11Zb1K/R0VmoSY4veF5AQB+Ux7AkLZNXkedcRgMMuU9TD7ng0lRfHIRbz436o52BfFzf57JVCS2BeYraPA2SLIAGBe7I74gX33xoRnqOq3SlDGRV2LVpTcPjyvwEE5JoH5EijWGsCVo9Lqz+0dVVEdkYwI1v1yPi8EajXzthvMND9Gp2eJZn2rNB/f3aqHL1zts5klhkjC5WGeVDb0nWfRYOK9YTW/UwmRNU6BrgLtQ7BKaiEp4HDy9PgeiThUYvQscChc4Brg34EK4NuLnY7q9RGOiGDUQu6PXph
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:54:42.0467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30758509-31ab-48c5-ff31-08df459d05f5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5671
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

Add a separate device-tree schema for Mali 5th-Gen AM GPUs.

AM_GOVERNOR controls GPU frequency. The GPU node does not accept OPP,
cooling or GPU supply properties.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v3:
- Drop the $nodename constraint from the AM GPU binding.
- Require the arm,zena-css-mali integration compatible followed by
  the arm,mali-gen5-am fallback.
- Update the binding example to use the new compatible, three-cell
  interrupt specifiers, and a single GPU clock.
v2:
- Move arm,mali-gen5-am support from arm,mali-valhall-csf.yaml to a
  separate arm,mali-gen5-am.yaml schema.
- Move the AM GPU example to the new schema and add the interrupt
  binding headers.
- Add the new schema to the Panthor MAINTAINERS entry.

 .../bindings/gpu/arm,mali-gen5-am.yaml        | 89 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
new file mode 100644
index 0000000000000..af758daec2aeb
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/arm,mali-gen5-am.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Mali 5th Gen AM GPU
+
+maintainers:
+  - Liviu Dudau <liviu.dudau@arm.com>
+  - Boris Brezillon <boris.brezillon@collabora.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - arm,zena-css-mali
+      - const: arm,mali-gen5-am
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Job interrupt
+      - description: MMU interrupt
+      - description: GPU interrupt
+
+  interrupt-names:
+    items:
+      - const: job
+      - const: mmu
+      - const: gpu
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core
+      - enum:
+          - coregroup
+          - stacks
+      - const: stacks
+
+  nvmem-cells:
+    items:
+      - description: bitmask of functional shader cores
+
+  nvmem-cell-names:
+    items:
+      - const: shader-present
+
+  power-domains:
+    minItems: 1
+    maxItems: 5
+
+  power-domain-names:
+    minItems: 1
+    maxItems: 5
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpu@100000 {
+        compatible = "arm,zena-css-mali", "arm,mali-gen5-am";
+        reg = <0x100000 0x480000>;
+        interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "job", "mmu", "gpu";
+        clocks = <&gpu_clk>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index bcade5bfbafe9..93ee837af9958 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2404,6 +2404,7 @@ R:	Chris Diamand <chris.diamand@arm.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/gpu/arm,mali-gen5-am*.yaml
 F:	Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
 F:	drivers/gpu/drm/ci/xfails/panthor*
 F:	drivers/gpu/drm/panthor/
--
2.43.0

