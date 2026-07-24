Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1C3C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9960E10E056;
	Fri, 24 Jul 2026 11:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RNIpZY3B";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E305C10E04E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 11:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEJUAsbNMNx8mVWw6XCTyAijRyqacuevBXubapzLzeFdIW72DSC7R2y4Yov/ZRhcrxwSIT56e3jgSM9hMLxtV24QRl4Ipv9wRhg/n0x+2WNgGTO37euPthIR03HgJ7hlU8QlNsXUV3/HeCNzLk0OsDpBMy4T2HJZM2qFis+QAUAPUjQXXu1cmpyMfoY+iexkmCF6gqWInl3ItuQDbGvn3sbsMjQgn6uPGHg8ZLjMeyPbOiuatwNAuhllujpOEqzVHtysBduVwejx3rUSNVJotcwLXSddHpMPjbMbXQnLbg9xzOZsBlBEbED92C95T5dNvY9nJAzBBS8Bi5qypwiipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmLlFIgaTu5LB9vap/cEnzerfWMP353FZJMTeSCt24E=;
 b=jXKovgCB47N0duvCrvWNP+143Ac4ilI8v9NYwFtZeVZcu6TjZt3mUSZcUX9ZPP+gpKyYY1a5D13r84UQ3KTSDXMk/CppLcNMZz4Xo3BsFb5ImXLSO0I3SAfzrGM2e8KDkrdt0xWMNXSx4/OotTqWE5cWogNxb4ns9vt543bGeCcQzBuGX1Mfj+4VDcNp7weri63KvS5GR2Fr6RTxECzs/nxW8ZP1/4/9Ihm0TdSyy9JzkTN/tXXYR/VVQkTMREZxfy2UU+hYYqwKK1uPULY7mRh7M7eC6KI/AjV+r0gusQQicA6GWzvRksHHmWQt/JmU+OPRsjXHKoWrlv2rcQOKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmLlFIgaTu5LB9vap/cEnzerfWMP353FZJMTeSCt24E=;
 b=RNIpZY3BydS9aBS5pYBaiAvE3nJHcMtxAcAxr1VMHinRPZ+heQX4QJExd10RdXrBLjJKJkYWkU6tNZeuwP9QATYuLl5JfihFGu6rLtr2/gmUDJSJj7VUHx99EuM/SktLIeH+Cd4xZtFkLQN7jhvmB4KB4v8KWswGsx2R5Ugfgm/tKagkcsjmAenw25cn3LA24S52LNZsfOqRmkjqfExT/DMr/o/i+MAHW/48PifKx4qqif0KKVO4fgQgfIy2qrMC/iAIQRNThf0BcjPl58mBilkJX35GXNw/PO0OJ7dtUqE7TjcGLQB+gCIORAhteNQbCnNOD4VGG+jXaMoTjujTsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6974.namprd12.prod.outlook.com (2603:10b6:303:207::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 11:37:14 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 11:37:14 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 0/3] rust: io: register: a few fixups
Date: Fri, 24 Jul 2026 20:37:03 +0900
Message-Id: <20260724-registers_fix-v2-0-a0fb58b02185@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NwQ6CMBBEf4Xs2ZpuMVQ9+R+GmLYssCYCabHRk
 P67BW4e32TmzQKBPFOAa7GAp8iBxyGDOhTgejN0JLjJDEqqSp7wLDx1HGby4dHyR2hTabLUXqy
 RkDeTpxxvvnu9c3jbJ7l5layNPq9H/90OI6693a0V/rkjCilKjWhViZqwvQ2RGzZHN76gTin9A
 LGZ+X69AAAA
X-Change-ID: 20260418-registers_fix-7a67ebef9ba0
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0116.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 771b49df-d3f0-452c-fabf-08dee977e877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|11063799006|56012099006|10067099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: 4t+8sb93/filrNjje6OGXlOgVmTzCvWPkeG/Qj4Sa6N99n6NrwGiXIr4pwB1WT84sa5ZXcXCFWMUyqXcHE+DFPM1zBCChx+Ix3r7CiR7/7Lz7+b8IhH0pfNEhRVpcM2O15ZvdcmhCTLIyyxF7+0ogp0wpnCXGBlxwOYSXRfY2rk8XIeugT1OC/WTs1BG+yUNQxybZzLWFE34n8MLsOpZqvFuUGElc1CXD/JE4dXfqb3QEi40rbbOtXXxVY4wxaQy8ArhplygLdWYHkyj9/QByc6gNhk6sZ3nGb9dJEk9ErQScTcslA7E58v4/4S7UDymTCk9VyEV8H+ajzek9XuBA01OHMHfoJZfpYqvjLB5JexSQMSAwpp9j1HV9JC1tCgzpq6RGowudXppebDu0PY5oOdRNA0MaNt/YD0zOGXnMZm0Ck0lj7tih0FllxyezshYM3WudIpdbbpxNEV/QI98YrYFDXMXI3fEvjOsZHHo/OYwbrEkFZ1hvNZywRm67+f7Xk3V5ThQJWldMOWYRqWFLU7xzB2rIfov0HkI/OCWXy3WMy2XuN+6fB2XXDDgt1vHH3O7GR1SFUzW7Ehi+UtlizrdvRhwD1F9AupfZMsOx0L9Tc7fShftBBUrQQFDuhEiEJ/44rel44OTjksoqSqYAnalWCglBqoE3xumMf20mgofF7iL+Z7/Wsjsr4BdAvCjPMmAjhrI8Wr5AKyyOTJjzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlJjdzlZcEo4djcvVTlQelFnczNyc2JxbGN3b3hmZ2U0TWJCbmYvR09BR25r?=
 =?utf-8?B?N1doOElBU0ZwV2Zrejg4WmtZdzJscmI4dXhSYlZ5TGhlQitHYUxBTXhiRy9L?=
 =?utf-8?B?MG5oakY1RnNBNlBSN2h6L2h4dHJZQTVIWGovM3U3UEx1WDZ6K1RxOW5aMFhi?=
 =?utf-8?B?UlRQT2ZUc0YrTHdmM1JSM1B5ci8zRHVNVENtSjVnTHRadHQ0U1V2Mk9pM1cx?=
 =?utf-8?B?L0lEcXgyNno5SmZzaW9Va3dqWG0zditJaUdkVDV6M2xhcDNMUjBzQktMdTBG?=
 =?utf-8?B?amttSFhiY1pvZ1hMSXhjT1NqTHBxcEV2aGJTTTRva09jakpuNEdybzdieE9T?=
 =?utf-8?B?bk1HdVI3Q1gxZEhBTnNqVU5pdWs1SkFaRmxwVWIxWEJCQWIwSmdacS9FZzJH?=
 =?utf-8?B?UnVVM1VXTXQ5VmI1d2VtKzV4aHVDM2p5NjYxV2l1MVlQejQ5Q3d0L1ZXbEw3?=
 =?utf-8?B?c0haNFJmeG1FbHBlWGRrclRQUEZFRDI2RHUxTXM4bUVXcjVkbmt0cDhKQzEr?=
 =?utf-8?B?eWpBM2RGWjFhN21OT1VZcGp0VGNJYWV4eFI5STBuTHpuVUpGTEZ3VXUwT0Fr?=
 =?utf-8?B?TEN1Y2RteS83MTgrcW4vdWJOTy9oZ2R1ckV4QlBQc0pneHdvUUhVWVFMUDRa?=
 =?utf-8?B?a0NGZnlMSGxSdzJKTnJmN1FIbUJqQ3MveWlXa2dZV094MnFSejgzdnJVT0xF?=
 =?utf-8?B?UjBFZDlvQng2d1Y3SitZdkM2S3BPZmVrMHBCNU1UeURTOVQyaWJ4alArVkNY?=
 =?utf-8?B?bklMems5MTBpdUZmNEZPK3hQQ2h1Nmdzb2N4TFNMZm1KV2ZzZmhVZlVyZDBj?=
 =?utf-8?B?bU55NU1EQUNhQ3NXcXdLZjJPallqOG1VSkdNbHNzSk9KMkc4U0hTUnpzTS9l?=
 =?utf-8?B?UGhreFdXN3FpaDUzWkxXTUVIaHp4dzhKWThvRlU0OStJbWpvbWdqWjBJNEwz?=
 =?utf-8?B?SXQ1dGw2NFJ5TmJaN1U3V2lOKzUyemx0QmtZYUhRakpVMVhkZkNBbXoyTWt6?=
 =?utf-8?B?czV6OWdOWVh1NE5iVFFkYzJqU01DTFZ0cU4yWE1ZSDVKamlTR1VWMGZLQkxa?=
 =?utf-8?B?Ukl0UVBaQ3JxZlNaVmMraTlpUkVjc2JBVFdTWGhwd3FTSWI2OEd1QUpLQ3Vr?=
 =?utf-8?B?NndOYzNCNHRwL3pBRFNCWUxNUG55cWdhZFF4VjIzQVlzaXpqMjZHUVA5bzRl?=
 =?utf-8?B?U3ZGeG9TN3RaQlpWTWIrYmpza3I1S0lGeFJ1SnZTKzRHVll5eTlpa242bC9v?=
 =?utf-8?B?OTlyUGNQcmE5UzZxdVZ5STlya042clJGenF1SFFmQmVjdDhVSzJmN2RuVG5E?=
 =?utf-8?B?T3cwTUIvanVSUmVHSWlHWDZBdFhKeEdDZHN1WE9kWStPaUs5RVdNNWJPcFFZ?=
 =?utf-8?B?SW0wdTNJLzNJajVBRThTWmZuQ0tGZWkyQWhEUU43U0R2bmlmbnRyYVpMMmNQ?=
 =?utf-8?B?V3hsallVditQVHAyU2hDdFVQKzhXLytGSGpOeWJYNnZOVUFtMHI5UFR0bDli?=
 =?utf-8?B?WERHekNiN2EvK3M5VGNaKzMxeFc3bHV5UW54S21pUmtYeFlNVldMVnY4YXFt?=
 =?utf-8?B?UWQxV3pCckk1Z3NPeThBK0ptMW5ibmtIQ0JqOFp3OWlxdys5UFhCM3dXU2Jn?=
 =?utf-8?B?Y2tQdW9ZSzhyTGhESE95QnQxekxVY3ZZZEpoQlZZMFp6VlNzdTA3a29SbzRE?=
 =?utf-8?B?azlkYURLWWZxSmFPSzduSGxxZTNNY1E1MWxQWS9CakpLcUdBS1FRbjVLaFpB?=
 =?utf-8?B?cVJacnY1SVRTREZoaHZIT0lzNHpINENTQWFBTHpRRVZuMHBtV01YMjNNeW5Y?=
 =?utf-8?B?R3EwU2QxZTJ3aUlTeWZpcTZnemdkVUVIVlo2Y1NUMHlWVmo3YWNYd0xjMzJY?=
 =?utf-8?B?blJzSll1OEx1d1Q1SXo1WDZVTEQ0OUlKbFFNUnZuK0p4ZVI3S0t6S2ttaWIv?=
 =?utf-8?B?UzdTdE10VWwxb09OYmRHSVJhUkk2b0xnWEI3YUdQVGZ1TEllRG5JWWIwT1ZF?=
 =?utf-8?B?S3BnTjdTRzV3UXpsSXNmR0ZEUHc2dHQ4eXoyOEJwc0dueEw5d0lFTDFON05m?=
 =?utf-8?B?aXNQNEt1aEp1SmpOS0hCNkNRMXJKd2FEWXY1U3NIQnB1engzWU9OZHBNNFRB?=
 =?utf-8?B?bkJUcXVkaEYzQkhBbm9OMEsyQlZuei9qY3RTWkpmMWFPWHVTcUZ2UDNXRHZH?=
 =?utf-8?B?ZGppQ0xPV0NRM0pvQmkrNVV5V0xIOGRKU3VBc21WSmtFT2dGdGZvZ29WS1ZZ?=
 =?utf-8?B?WmFQcmVROThTMDNOYkw0bTFhay8vaFAyNTgzdWZhV0dqNlNydkdFeTJyUS83?=
 =?utf-8?B?YjRYSkl1VFh4MEZyYk4wdFJEZkFJLy8rTjJKdnYwT1JiNUVJUEQybVJrcDdl?=
 =?utf-8?Q?xfNgiiQUKMoI213vgeD+LQxDK53aIoE54yUsSxUHDKvU7?=
X-MS-Exchange-AntiSpam-MessageData-1: oXHp8WB3/72Tcw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771b49df-d3f0-452c-fabf-08dee977e877
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 11:37:14.5601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1V3LLwISyIyEZRqEMNpPtWxkTF6DY+TJCWAo775k8JeNnHewrVlIqaA7NtZl9lf8oQBy/XkddcRNhVEKfHKSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6974
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

These patches implement a few fixes to the register macro, notably
removing unused arguments from internal rules, and using the `path`
fragment instead of `ident` when defining a register alias, since the
aliased register is a type.

It is considerably stripped down from the first revision; the original
goal of the series was to fix an inconsistency with the way relative
registers are defined, but since these are likely to go away soon [1],
this part has been dropped and only these minor fixes remain.

This series applies on top of drm-rust-next.

[1] https://lore.kernel.org/all/20260721-typed_register-v1-0-452d72b60262@garyguo.net/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v2:
- Move a missed conversion of an internal rule to patch 1.
- Remove all patches related to relative registers.
- Link to v1: https://patch.msgid.link/20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com

---
Alexandre Courbot (3):
      rust: io: register: dispatch shortcut rules internally
      rust: io: register: remove unused rule arguments
      rust: io: register: use path fragment for alias destination

 rust/kernel/io/register.rs | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)
---
base-commit: 6dcbb4b1320fa91fee349462a52bb69135f2e45e
change-id: 20260418-registers_fix-7a67ebef9ba0

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

