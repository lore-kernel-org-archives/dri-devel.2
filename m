Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE10606A337
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=e2FwC4fz;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=e2FwC4fz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BDED10FAE5;
	Wed, 11 Nov 2026 11:05:06 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC76F10FAF8
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:04:54 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=l4v02vTF5v4EMYJcZB3UBLUvnKy7ico7r85cBDAU6TUS97k70IJEFdwjf1fLbgLqnY59dvpBQ0xzvZC0Z4YklLaeZZlGcVb71vFomADVRPwiOT7yss8C90AgxhxUCh8Fpollajda59eXiL/orgyq6wtGInQqPoLRPlVW400wLUDXVdpXQzgOn83POocT4OvjSzUvN52muAiEz8MQfzUe2Ko4f9VqyCnCvrGdrdFtHkmFxU+4LloxnQg0sIap0bJgkX2WeOy9hocNW5ZBg2Ck2LyObi6y5D8uz7Wse6eBFTcNgBKu31ZICY0wBeR5EqlCgxGKNkEsSTEVkjfoe/6hZQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxDj6gi58af8AS89NjVzDxtAe/mALuYuISBYkOS+cRg=;
 b=hysJVP6XXf66aDxTLnC9jKt8hvUb6fycdnvQrzih2/KR96YrmJzAVQhubEGxr1Veb6m1Ie5V8HxfG2MJAZwRNJv/3adxf19sc3CDIkZwNJyxnDvdl0IHh0nC8ln2ya8s81SnFvsBU5Fbur91IDsbjvvoglkiEgsOuuQ77k8z5JFvbd+XGgOaWd/HEcxdBqn0SLbJs7/aBBbdCcfdM2JkhJwbskgdKxg2/nWPh3M3IBMsc0e9oz8wBy4GWT/9MPIzGyhs0hQcUTzyTkDTibOheNdfbQFzaREArnQKkq27ljk7rrgpAjG7cWlytRKP9pXRY+hXaTsVowoz69YjekY7Vg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxDj6gi58af8AS89NjVzDxtAe/mALuYuISBYkOS+cRg=;
 b=e2FwC4fzJY6gJk7u2odrnkpRIqDy6BfQ3mWSCNOJ+YFt6ccMh7W4JWodlbpfm7uESUYH2oT2lmVB8KARxb185P+/nteq1bwWsd8su5UbaiEzI7HjAwux3IzvBnAbN4MebdztjlBuEAAzvheqlG8DCLrU/8avYMBSoyF1DIvWz/8=
Received: from PAZP264CA0007.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:21::12)
 by AS2PR08MB8694.eurprd08.prod.outlook.com (2603:10a6:20b:55d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 11:04:42 +0000
Received: from MI3PEPF00008554.eurprd05.prod.outlook.com
 (2603:10a6:102:21:cafe::7f) by PAZP264CA0007.outlook.office365.com
 (2603:10a6:102:21::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 11:04:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008554.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 11:04:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORemM0wumSOx5ZojMKrjWYD5/dHe8hYJgnr8eQD50ZUN2i9HmDb5/2v/x/iRBnSVom0Nj2qAkIj4fZF9x3q/eXr34fFar95dCZ88+LZXJ93u+XG0WhwxLgPcGlYy+aH1flsx2BSTpSLbGxTc1IB9qRafGVtAwvHYBR4ULz57R+OKJJxwN2//iySXT+bO9PDiU5Nwsutwdaa3otgHkeLa6xz/HXmRXz5qPTnqBh3ZfPUfEyZXUFWEdqhg7LQR8QqPewsafKI4EJ/TXI3kr5Lvw8oYpqm2Vp1QrfpDElIZkdNE4TCsjRfs6k6WfZ2qZEc2bp/xbkZwCnw3xye7y6JPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxDj6gi58af8AS89NjVzDxtAe/mALuYuISBYkOS+cRg=;
 b=eiqR9jY4lA6xEqiJBOOfrCljLzABgRkdl3hqAR91tWwrjdmkv2VD6JomGICAlvn3ktmG/C2pA9ksyYrXSoVFG1+abCgRZ6T803QgjBEZ4ocToFI4EkUK4CCR5FIH09O20cDCSdlP233Z01gVPJIfaoWNvlGMst2NGBFNDTZMAmum6lOuF4VKX3zYyNbHIEwXcwqQ/fjyuZGbHaorYBBr6tvFlOiwI0U8krdLtrkSQg3C5fGXDX3sJVlp3+PtAiofw+l1bfQI1Zcyv1ugYi4QmRLvFPhAE1XmL2+AzO7ybLt4I9SnXmHWG6XXMOJrjZAJD6/iTT5MM5XAogNucYJ17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxDj6gi58af8AS89NjVzDxtAe/mALuYuISBYkOS+cRg=;
 b=e2FwC4fzJY6gJk7u2odrnkpRIqDy6BfQ3mWSCNOJ+YFt6ccMh7W4JWodlbpfm7uESUYH2oT2lmVB8KARxb185P+/nteq1bwWsd8su5UbaiEzI7HjAwux3IzvBnAbN4MebdztjlBuEAAzvheqlG8DCLrU/8avYMBSoyF1DIvWz/8=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB11986.eurprd08.prod.outlook.com
 (2603:10a6:800:343::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 11:04:05 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 11:04:04 +0000
Message-ID: <ede1710b-cc07-4201-8937-b8420259d512@arm.com>
Date: Wed, 11 Nov 2026 11:04:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/28] dt-bindings: gpu: mali-gen5-am: Add Mali 5th-Gen
 AM schema
Content-Language: en-GB
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-9-karunika.choo@arm.com>
 <20261111-accelerated-pretty-spoonbill-0afdcc@quoll>
 <3a63f0dc-9939-4c9f-8050-303cdcaad2d5@arm.com>
 <05a92dfc-c74f-46a3-ba44-60f7ef1c1a54@kernel.org>
From: Karunika Choo <karunika.choo@arm.com>
In-Reply-To: <05a92dfc-c74f-46a3-ba44-60f7ef1c1a54@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA3P292CA0017.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:47::8) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB11986:EE_|MI3PEPF00008554:EE_|AS2PR08MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: ad605ccb-e59e-4c36-3b5b-08df3fe3943c
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|261009223027099003|3023799007|11063799006|4143699003|56012099006|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: lA0nSkDm7ykZZJwagdI3e3fbh815VokvD6g+vjpY2KqEfuJc2Uxnd/yRKiRroan7/R06tPal0byKklhp4JehwL4Fv/dxwtQ+MA6hrYVGNlgbXcWXZQau9ddWkvIqTMAym2NOd/rHmV/lQOk7sJCZSNfuMWp/lH9yvQ+hwUPDuBV1Rk05xSNgPORZwtL9fah46EqnqSBlQf1oYtKu00lpnAg/sVrFt4RyeZFr745V8YrQX39RiKBifv0/ZcAp2WQPe6UeunTTVZZoJEWpdoyR7SGPn++Gx/aBZ7+20TVj05/T64U771wpqNzwT4k5F5TQzLHhpOYYAoX8SdWBNudbSFriTC/su7OJTHeESpJ3U3BWM+1FBeTsVedar3wHsFkAaFpBjKj9Lw51E4QG23q+ofnVNDsseCCc0wyS+neQKFdli5LUb16CsufEUqo1clqrexa6rnwpsM+OLoilPsBohZOej5N9CtXQMAStD8HFcU1qI9sU4LnYPGEFnkvYbFDk4yo8XXjmoMCx6eZTI8r5ge3b0lndLrnvq0UJEr3VbcmXBLtwlO/wDhPFYgXWz/HrVZnR3HU/mQRA/BogzGENZOg3QgBaAqUdgJ1apyuDY3Y=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(3023799007)(11063799006)(4143699003)(56012099006)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: puNRF7qEwJOuVq2Y7CaNuF0+o+nKpg8Yi5EqgE3POuLA4zmvZE2iw8CbwxGj+lwclZvq+7oSBx7fbPM828NcSVM4TJ/M8pN3O0IrtzNN/Hxk5KLrPuDhLE7qcGx0ID447R30lR5g/IxQIX5zXGkq+ZOp0JjQ8hC3Gd+8BIfvLP0Hxx+55gYtrq3d3aFSZopfTbYs/GIaXp5ACZ8rVkr4mCRWLFvDIg5ENUD4XLvCxiDdSUlCOEIdQzJNP987ACpk9ov/a1jFFP+MbW7CPyzsuzWjTFE+j6SQ1GIz1Juf3wVRQfN/XGzX1thGDgYrLpJXDxgbrvmh9f9MJP/car3YGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11986
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008554.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 853433eb-4c8b-41c3-1b7f-08df3fe38004
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|14060799003|1800799024|35042699022|7416014|82310400026|23010399003|11063799006|4143699003|261022075727099003|261026121527099003|261009223027099003|261028144727099003|56012099006|261022105027099003|261026140227099003|261021121427099003|261102123227099003|22082099003|18002099003|10067099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: dJbiNPCEQsVZg2X9RG/fUuAi03qp7rbTF+CDTE6+RmiCoclOvG/SXI8LGPgRo13JEzNbsgHjVNIqoX+M/L7X+HVrw3z6CWXQe8lRTeOsRt1t2hPUxfomX65BjbHIV7PAZwQ4znn12uGj7Deu2+xIjO6PORV+a+dZUcf2EwptMqpqh+IulgcBh+vHPXq3JkjfN7jdWnrhVsTezwltr6sIgZV0Nij/3GOqxB0jT6YcuDgP0JwhWI9hKX0ws4wkIGUP6cMQd5Nu4vlQvXk1rZYhTsa6yAmPaaR/26HJerjejUDC+TOEi+ahNhp+QgtfWQ9bBwc4LfoMnTxbLJmVqT+ZIemmmAL2UiK25ulTBA9XlUAKgsNsK9Oh+l366JXTscBSShZBJ5XATjMJzGIZPtes4ZtbXsk2gocz5DTdElUgOa9dpNgVoxB1J6R2DxNbMN4Npvw0+prkOxGI+ysUfIhhxmyV6FhtqwkTzq6mo4lWC7ZDMHLOaKn6O39HN/ClqLUDoLGdH/gLmLuS73WIf57cElqhy4QeHAe382fILNmQK8BBN4qz0S/4rhjbDz+BhMLaP4aLOsC/enb+HzJkYF9IWJ++aKndOWbQjmqZqPlEajRfTXyoNn8TMenUaNN98YUjtkLgr6EJixqOkcqt6ME6Gw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(14060799003)(1800799024)(35042699022)(7416014)(82310400026)(23010399003)(11063799006)(4143699003)(261022075727099003)(261026121527099003)(261009223027099003)(261028144727099003)(56012099006)(261022105027099003)(261026140227099003)(261021121427099003)(261102123227099003)(22082099003)(18002099003)(10067099003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kPbNl3y5S9Qu69M8QU/paxCsFcXFuhSD2XSt8NgUfArI7PUtZKqrRa42ofrJNCMrJURNqTR2N8Uwkvx75kPNsQvf/VhlR6aSbV2Y/9yi09gU3y2fscNrnFUOdRNMeA+dS3Iq2E6JaNQFXSq+Y2PyGbXEPNWCiwBLXGod+eqQCXqRgtqrPOR5JqIoJPWk/Vbv84RkE3r4eKwteDQ/tz1cIm5QN2iUacGZEZ/k8f82hRYYjGMnN9IqxfxVT54Ml/gN3ifZTCqdYmYzxWUJ3FG+jgS5Tybc6/8kbc1LzXaupYLld6nbhPVBTTv7Mc4OyyD5RLiBN/7/K1ayLAryuVk5ucSCqqrBcZanIMDpoDtznUu5O8QCbr0ddxJPdWfEow6y2bMt8AN4zWXs1HLFMmR9a3Udp3SgpBXAdVQ7TVMRcGejwygEZHJUJtew2JadbOQr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 11:04:38.5240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad605ccb-e59e-4c36-3b5b-08df3fe3943c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008554.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8694
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 10:41, Krzysztof Kozlowski wrote:
> On 11/11/2026 11:32, Karunika Choo wrote:
>> On 11/11/2026 08:33, Krzysztof Kozlowski wrote:
>>> On Tue, Nov 10, 2026 at 03:38:29PM +0000, Karunika Choo wrote:
>>>> Add a separate device-tree schema for Mali 5th-Gen AM GPUs.
>>>>
>>>> AM_GOVERNOR controls GPU frequency. The GPU node does not accept OPP,
>>>> cooling or GPU supply properties.
>>>>
>>>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
>>>> ---
>>>> v2:
>>>> - Move arm,mali-gen5-am support from arm,mali-valhall-csf.yaml to a
>>>>   separate arm,mali-gen5-am.yaml schema.
>>>> - Move the AM GPU example to the new schema and add the interrupt
>>>>   binding headers.
>>>> - Add the new schema to the Panthor MAINTAINERS entry.
>>>>
>>>>  .../bindings/gpu/arm,mali-gen5-am.yaml        | 90 +++++++++++++++++++
>>>>  MAINTAINERS                                   |  1 +
>>>>  2 files changed, 91 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
>>>> new file mode 100644
>>>> index 0000000000000..6349888e1ae2a
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
>>>> @@ -0,0 +1,90 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/gpu/arm,mali-gen5-am.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: ARM Mali 5th Gen AM GPU
>>>> +
>>>> +maintainers:
>>>> +  - Liviu Dudau <liviu.dudau@arm.com>
>>>> +  - Boris Brezillon <boris.brezillon@collabora.com>
>>>> +
>>>> +properties:
>>>> +  $nodename:
>>>> +    pattern: '^gpu@[a-f0-9]+$'
>>>
>>> Same comments as last time.
>>
>> Sorry, do you mean that 'gpu' not generic enough?
> 
> I asked to drop the node name completely.
> 

ah! Understood. Will do that in v3.

>>
>>>> +
>>>> +  compatible:
>>>> +    const: arm,mali-gen5-am
>>>
>>> Same comments as last time. Seems like you just ignore review, so I will
>>> finish here.
>>>
>>
>> Hi, we are trying to provide initial support for v15. The vendor 
>> identifiers will be added once there is an available device.
>>
> 
> So how can this initial support be run? Which board has it? I received
> only three patches of entire thread, but if there was DTS I would be
> cc-ed. I can't find such patch.

Apologies for the trouble. This was tested on internal FPGAs, but let
me try to see if I can add a representative DTS for one of our publicly
available FVP platforms in v3.

> 
> Best regards,
> Krzysztof

