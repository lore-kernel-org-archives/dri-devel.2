Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA82CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 825CC10F69D;
	Tue, 13 Oct 2026 09:50:44 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010060.outbound.protection.outlook.com [52.101.84.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BCA610E76A
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:50:33 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KYsRWbXS2t97WpSsyZLTCWTtd9Np1Xfgtu7pwtzMVoCbE7mA5p1ADumJNqBeA0dyZWuPBVrJBDyBejDS2Fd1LMXyhxKsUuI1yaBWypFkgrLalVGzR8qR8oHrFIKIXWLZ/TmzQj1vMqlBEseEDjhr05/DfVnm9bv0q+ciE9+IyDgeTYwvSOF7zqXOpAPFPrPLe3Ohaiao+ltPu5Ey7YmHS0ciyDe1xuNfgO5giVzbPZkCxHu760rBg1i9i3y8zq9omuEy9Bx3wW3OtGCO8KlH83fSuV28WvduItu57awbKawhxvN4XhxVUui/WJFUuas9/R+/0hUaDKpO+ebq7Rgb+A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEKaQ8FcdPpu689AT67EptKE1lAI03ZOkFLMMoTPv1g=;
 b=r/o4QJc22eFJhrmB3zJKxrQBtUpYRUN5gMTyDwHGSdZIo3V1SfxACpu+LZwJDY9MTGKKDjc8S8WXiYhLy1+MLJebAIooGS1Su89YsYuaDf6C4NNK7MZ/OaGDXy6eDszOYTNidNeWq75L8s5f7ymQ6ekNTwZTWT44669R0++MQK8HPbWcu8NR5C5npmlK+EaUNCrppd4azQ1G5dBBO5QbTHO8IdqukMsA/AKe+l5Jbh2bL6J48eh0+VZMfYUvSgJXUcAVG/zCzV8Zg8XG7/YsSiP8euJzFwvoS5T/BHlHfpToDvDFUSwWO+Ok5AN2nYpfdkWZjtxtTZ3+9Ci9Yfv/OA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEKaQ8FcdPpu689AT67EptKE1lAI03ZOkFLMMoTPv1g=;
 b=os7Mqi4v+HiADAn0SNngMyQwqrK+kBZsG4GIob+P6FhMXGy3blYxvDC9g8m7/PhJek2uXBOW04Ind4x+D8SRGN05Z9ERbciNFq7+Vnon9CtKJruDAs1Z+8tVHmgUZ2ZDuXd3Dg1eHfa3ISRB01MPUp2fmZBXOo5W2O10wOoSAnY=
Received: from DUZP191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::18)
 by MIWPR08MB792857.eurprd08.prod.outlook.com (2603:10a6:290:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 09:50:30 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:4f9:cafe::22) by DUZP191CA0014.outlook.office365.com
 (2603:10a6:10:4f9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 09:50:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6 via
 Frontend Transport; Tue, 13 Oct 2026 09:50:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiWQVJ0ljFabREQlrTQkMx0qYRnGS5yRXrR9hZS2jLpm29Pm8gRTOp1rltb3nLRusxNqz82MInRw+oCyTfqgh/pdf4azp8VbSdvdU5t1kfTVKD6qFVOnsAAhyDbvk/20mrTD8tYDzMHuVrIzHhqyLuahLLQsCu/ZkDTCyZioQpCTgoUSqPkm7cdmagxabXzIRqnZp0uKRTVPNcLYNPoavyHcu4fQrEBrNqhAzbpCJyHxozHLMs+3zYtep9hVQMDTHgsxal+dsersEmnlE3ux6UaffcRtnvRaEFNBCT4S6dyG2g6mbI/uJKaOZOIgNosSojsFBe/0ndRCpQDAhF5Gig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEKaQ8FcdPpu689AT67EptKE1lAI03ZOkFLMMoTPv1g=;
 b=TC5KiMK9X7pwJA5NTr+FSEyP0wI529jk+efPzSNxrsNy+8M1EQUCPnL7U6poE/2trukZDpH2zn4TgNmNCS/zsM41GfjjsqSLlQQLRydX+gxLzImxKxrPXvZOOd5zQYvs52hV2VYEzj8/Wv1m2oUv0OHC2O96/MZA5BCyhda+5QLINUWv5iSRbRW8uhTjFeXGPR7vmxjaajo7oMYoQE6IGSBkIu76mPzVwqjcVM6eV1ToZZEpJGIXgeIoThfOtnsak4sw541Lp0imH/hNXSfl3Ud5CMUJ3MVGWYO0vPplj3WNg9tuEiTqOHR1wprgmahToTXKw+xhl1Ep6gr+KhOE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEKaQ8FcdPpu689AT67EptKE1lAI03ZOkFLMMoTPv1g=;
 b=os7Mqi4v+HiADAn0SNngMyQwqrK+kBZsG4GIob+P6FhMXGy3blYxvDC9g8m7/PhJek2uXBOW04Ind4x+D8SRGN05Z9ERbciNFq7+Vnon9CtKJruDAs1Z+8tVHmgUZ2ZDuXd3Dg1eHfa3ISRB01MPUp2fmZBXOo5W2O10wOoSAnY=
Received: from ZR6SPRMB0004.eurprd08.prod.outlook.com (2603:10a6:910:d7::10)
 by BESPR08MB134667.eurprd08.prod.outlook.com (2603:10a6:b10:131::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 09:49:58 +0000
Received: from ZR6SPRMB0004.eurprd08.prod.outlook.com
 ([fe80::b0b9:c1b4:6d4c:4d73]) by ZR6SPRMB0004.eurprd08.prod.outlook.com
 ([fe80::b0b9:c1b4:6d4c:4d73%6]) with mapi id 15.21.0522.006; Tue, 13 Oct 2026
 09:49:58 +0000
From: Erik Faye-Lund <Erik.Faye-Lund@arm.com>
To: "mripard@kernel.org" <mripard@kernel.org>
CC: Steven Price <Steven.Price@arm.com>, Karunika Choo
 <Karunika.Choo@arm.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "olvaffe@gmail.com" <olvaffe@gmail.com>,
 "airlied@gmail.com" <airlied@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
 "Boris Brezillon (boris.brezillon@collabora.com)"
 <boris.brezillon@collabora.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] odrm/panthor: fix immortalis condition
Thread-Topic: [PATCH] odrm/panthor: fix immortalis condition
Thread-Index: AQHdWvW2YAosyFNGq06s1Jw0mQLT/bb7Oc+AgAAAroA=
Date: Tue, 13 Oct 2026 09:49:58 +0000
Message-ID: <f9bfd50ed3d30da1f47de791fba3bf30f8fc41b3.camel@arm.com>
References: <20261013093150.4186117-1-erik.faye-lund@arm.com>
 <as3-CKkuP54UMDKe@houat>
In-Reply-To: <as3-CKkuP54UMDKe@houat>
Accept-Language: en-US, nb-NO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: ZR6SPRMB0004:EE_|BESPR08MB134667:EE_|DU6PEPF0000A7E3:EE_|MIWPR08MB792857:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b9339f-6721-45cc-d5dd-08df290f6a97
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|10067099003|11063799006|4143699003|261009223027099003|261009221227099003|56012099006|38070700021;
X-Microsoft-Antispam-Message-Info-Original: rFQxH3sxd8R44GsN+ZJmjTb7Y6+VdFjljdTaLdVaTyp8kgjr2e46aWljsqELCh2fei7Rab/WnEMvDwGdC/kUF0f+YwK7/gjZdQuI42pK/ueoh1BakEQVag7AtegzJQ+LznLjxhLOIoyfKGYj6r9L4fEUrWcav/B3fxS+NFWCl0wKEKbScL1lv6r3yEVXuPCxKYfW3OOtePcdcj0KzPPRmvoXhp35vB8RIXyhcxKMKInnnjTLanTejmnw+kNXCddP6YHF3QYCD8IU/br1hUPNbQ4zCEKxL5KxrA/9pzqZGVViKudMflR270hYJRx0A/TQn30OD4/9ClBpknMRM563v3ucD2aItLcb0COyqFuskaVynO7a1fqav/KkYyrQgonTGMwQIrdTNDA6yzsZQeEKExK4zuqv4I7FpITUlHIp7ESuX7fWJGlBC9beIIw6tV9hFQawuGqFnrRIegZ2Z9iCEQVQDTjfxZj7AahP391cylwj3ycLbAo9eMCSBAMlwwLgMLGK7DroD/GMoQ0CQqL2v5W/JlaMCEdzkmPxH8qbftTz5cU3Y/65pSHiPod5niqhOR5Az5XLLFhJRdN2umEgW2XBg8ffYrKJQLY1mgyxLFkSsOoWpTQzXDOeSUYuXB/0VHUt1VPytJ7v9mehy92rpSFKnQWAmNICfHzRjfaD4IyHNwegBH32mCOTQnVNp+56LMJY9LKKdEHb1U5aRAou103Gzkmifps0oRWoCdkcJ48=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:ZR6SPRMB0004.eurprd08.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(261009221227099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EF8014ABF0CBE448BAF519458722563@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l71/O7IP5QXzwb/mJ8KV4FciyVAuvmx+5zjKt8MC1MIMPCsISWIgkW4Xgwqlx93rSk6hUcW3hlbukCAC24pOMt/QvWozE59K1FkMx04VfA5bgc6mBU6LVhlz9A9LVBmiqlPa7xbBQoDDg41XsntpM1Vw28nq0BqoP2cpdH5tR6IoY3PQ8aEpJ1092GdH8yxdCXrcniFFpaQDsWTfSlRdhEOFxLFoefN1GsLdHZHgJndUMrg2z6ObXozmFdmlEk38wQBqNhWerBR15Ns2Lvd7oYRTZPgnFaOtgzdNMz6ps0oJGaxcJHdeNCGMXr3zJ2S3zJHdYcxPGGhONobkbMtyPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR08MB134667
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1c3cf8d7-91c9-4c6b-5acb-08df290f579b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|35042699022|14060799003|6133799003|18002099003|22082099003|10067099003|11063799006|261009221227099003|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: wa0LzpB7KmVad+9VWr8cfjY+LVhWNjRqwW7QmcOlv9IWjdAPRCJyT59SAcEh95gKiaLaCK7KZ5rdpUZ8C3vRy7v8X6vt7KT4sOdrnyx9EmrB5Xd7lrH0wGTES0SMyee+HxLSOC0PiZOVfIkwBYphha2cB15lsPi+J8pnm+I2OiSbC8blE/rwE//ig9/b8w0BfcUI4xbKZdrGv0d3KLkHjKjbVzxXk3eghxAfCqoqorZwj1BZFb10To07rSN4BeVNtOfLzymOTlXMlQ0v9ycZJ7Jntlfo8BMEe57K4SJSdZrNnwNvpgEo6FzP6L1rxrJLI6omUyVRfYV7LY2sJv9IwVTiRuaFdbaD8nRgF9JQukO+O4zyJ95UOGqqHbZki4OTkDPODSlo+Sud0eHLpTRkk9hhazrNA8dkp7CCx4RQV1iLAE0bJqmL0CRRoSmOfl9xeTALfbPuFQub9p87SLVSJbTErL4EFMEzZuaLtpf8iVRP07qt2mdlqdQZ3Xq37xFyXC9sccaE6xMBIXJGBRAU+A5cIzabwODL6DgsDxbOah3nF5NZxbUh2Y0m0PUUPabwEDrBxAyBptEH0bracoZg3lX1nJxhLjE+SBBTXEolckCUsKcpRpqHCrEt7s3jOGpn6fRMaPCqtQB+7go/OPH/mkaZOBf94FSsFVveTZfeD/1C3ME3HZTyIJSKMQnvgRP2y+gKGYWL/6qPOmCsGHFEWQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(35042699022)(14060799003)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(261009221227099003)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qPN1okkskvJLM8auHgqEnP0Y2rNg3DBbq9OiJTH1Nc4eFyuLKjwavK6Emd3BKcSI0BQiKp/1PT9sgI4HpR+ShKc3Y3n4OgAJMjb3j9n8obkLrHDoBq33mv0EIbkQfQJM8SSOS5PLfccO+oFScqAOYHNBrdD8ZwB9pVQoJUFGQhVeLlf0fa4CvWKV8HJhLRc93Gf0KNp7o/lskcQxL5wdbsALhzdyKRhUXyhguBISLzRpdaaysOoGN386pbpnOn1ziTkFN4IuxEJQkEYdrweA+vgNTwsx4Bg533kx8UUKAcCGTEogBDFNT9PR6JvSbqJREH2D4H7lXHIUJNHc2QjeuQ1qFRNl8nUkzI3A9tV4Xvs9PkFo3lbEkfDZ64oihtLI6DL6XzQzSC4JUE/ew7K+EFK0rq5Oa95MxM1bbRlV8rlhkrG3DNeuZJOJZiSjhjzM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:50:29.8396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b9339f-6721-45cc-d5dd-08df290f6a97
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB792857
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

T24gVHVlLCAyMDI2LTEwLTEzIGF0IDExOjQ3ICswMjAwLCBNYXhpbWUgUmlwYXJkIHdyb3RlOg0K
PiBIaSwNCj4gDQo+IFRoZXJlJ3MgYSB0eXBvIGluIHRoZSBwYXRjaCB0aXRsZSAob2RybSB2cyBk
cm0pDQo+IA0KPiBPbiBUdWUsIE9jdCAxMywgMjAyNiBhdCAxMTozMTo1MEFNICswMjAwLCBFcmlr
IEZheWUtTHVuZCB3cm90ZToNCj4gPiBFeGFjdGx5IDEwIGNvcmVzIGlzIGFsc28gdmFsaWQgZm9y
IGFuIEltbW9ydGFsaXMgY29uZmlndXJhdGlvbiwNCj4gPiBhY2NvcmRpbmcgdG8gdGhlIHB1Ymxp
YyBkb2N1bWVudGF0aW9uOg0KPiA+IA0KPiA+IGh0dHBzOi8vc3VwcG9ydC5hcm0uY29tL2NvbXB1
dGUtaXAvaW1tb3J0YWxpcy1nNzE1DQo+ID4gDQo+ID4gU28gbGV0J3MgcmVwb3J0IHRoaXMgRzcx
NSB3aXRoIDEwIGNvcmVzIGFzIEltbW9ydGFsaXMgYXMgd2VsbCwgYXMNCj4gPiBsb25nDQo+ID4g
YXMgaXQgc3VwcG9ydHMgdGhlIHJheS1pbnRlcnNlY3Rpb24gZmVhdHVyZS4gVGhpcyBtYXRjaGVz
IHdoYXQgd2UNCj4gPiBkbyBmb3INCj4gPiBtb3JlIHJlY2VudCBHUFVzIGFzIHdlbGwuDQo+ID4g
DQo+ID4gRml4ZXM6IDNiMWRjMjFkNmQ4MCAoImRybS9wYW50aG9yOiBBZGQgc3VwcG9ydCBmb3Ig
TWFsaS1HeDE1IGZhbWlseQ0KPiA+IG9mIEdQVXMiKQ0KPiANCj4gQW5kIHlvdSdyZSBtaXNzaW5n
IHlvdXIgU29CDQo+IA0KPiBNYXhpbWUNCg0KTXkgYXBwb2xvZ2llcywgSSBpbnRlbnRpb25hbGx5
IGxlZnQgaXQgb3V0IGxvY2FsbHkgd2hpbGUgdmVyaWZ5aW5nDQppbnRlcm5hbCBhcHByb3ZhbHMg
Zm9yIHNlbmRpbmcgaXQgb3V0LCBhbmQgZm9yZ290IHRvIGFwcGx5IGJlZm9yZQ0Kc2VuZGluZy4g
SGVyZSdzIHRoZSBTb0IgbGluZSwgaW4gY2FzZSBhbnlvbmUgd2FudHMgdG8gYWRkIGl0IHdoaWxl
DQphcHBseWluZyB0aGUgcGF0Y2guIElmIG5vdCwgSSBjYW4gcmVzZW5kLg0KDQpTaWduZWQtb2Zm
LWJ5OiBFcmlrIEZheWUtTHVuZCA8ZXJpay5mYXllLWx1bmRAYXJtLmNvbT4NCg==
