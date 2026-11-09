Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55E60A3806
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m5PY75fO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8669C10F0B9;
	Mon,  9 Nov 2026 08:33:28 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DE310F0B9
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 08:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=np3j16jSCBOOlkGnvGLL1ML0gLnjnhvGDIDnDOzqNOg97O0GTiPQisBRz7uZprIgBy912MBEBGWezzuvR9bLXraLmNbItVKW9ajqqMGSda9rb6gaT/zHEV7omATZFkFTBH5aNeybdAL/H/Yc1r8MT9pdZrggLhGAcO2lJhHiz4dLCZIviVPo+jXTLUCP8qbYSdpL1XAfersJ125p3G2m5HL2JAmifZdg2mU2qHrvDJZfG7fSEEgpn75vzn+JWaf3EuVlMpvTqcSj3KDK4YTFjlv7cR3gTz3vjfbXB8RJ6RqKhcVCOl0zLcuFyXwORcHrBqkYP9OM2/dCdTeVgP5XKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1r+A6cqtFDcoGxJjhkdme4gKf+rCWgwqoBqCpUSm1PI=;
 b=tOli5+HFGAAwr+5j+uezN83EdhziVdr3dmryJPUNHHYRXevL5cbMti1/PmZ1kPSB1W+SIJzASHobraPFtRR6kLKYu38T6+AVQ5MX2emKTPPoedmnNwWwsfwDyn2/JBKkFK5oqkO7oU5UGQ1ipEW58nze+Ox4KuMHmhQZTbzrjmZOrs4nfL5bqgr2Sk0MyfxD4eBghiN2x9HcVWXPFXHANwC9gfq4WrfY+LTmyvDZu/hNDSK6LgMRYzQvQ8c6zKRwoxt3QQH9pfl9q/SHrvfFQsjfU4uH34wBX1dBuZAi4DyRKbuCQ+DILMktFHu7YuUvEr4Dhc9eThHJHgFXT+Fgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r+A6cqtFDcoGxJjhkdme4gKf+rCWgwqoBqCpUSm1PI=;
 b=m5PY75fO5Rz8/GYS5hmWFgCWYPk/F0+93f/2N3Y7c04YmIjgpTzvqab4PB0Kh8I4jmaXIkd2/4zy4wURDoIe38aMmnA72pVhwkCxjECgahXcuKjE6gVQ2ItHFw4IMmfJe9Lwgm+/bTEb8b+SYqUVnyXfjfdaFmrutzxary5fk9GqnfZeudmyurbYM+//Y9NPdoTvYLgAWD5QZ78Kpeflm99oMD/Lfu2aa/6ISDAIvbjv9EjxTFN86mHrEqISdhzHau0wZx9dMevEnGsBqIRqgUgcCLKsy+88sPuTHsVu2TsgcTB7WxMOECbeJFUhP26VobiaaxYew+QZFEiMdcWBmA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB999229.namprd12.prod.outlook.com (2603:10b6:806:4db::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 08:33:14 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 08:33:14 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 09 Nov 2026 17:32:51 +0900
Subject: [PATCH v11 3/5] gpu: nova-core: use Alignment size constants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-chid-v11-3-082aa9bf5a91@nvidia.com>
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
In-Reply-To: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0161.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB999229:EE_
X-MS-Office365-Filtering-Correlation-Id: 774f74cd-29ca-4ab7-2c00-08df3e3c185b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|10070799003|376014|22082099003|18002099003|6133799003|10067099003|921020|11063799006|261028144727099003|261026121527099003|261102123227099003|261022115727099003|261022075727099003|261022105027099003|56012099006|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: oymxc2C/IxzxOg7WrXXHZU/NynJKXQ+B/SvNx9GxJcRGZ6nP7bFwlknVTnL8s5RY8b/I1QKlyB6JAUpizFSXGZbhKahQKk6Odn9bB++ATmoWHYSIq6Uy8AZlxwSet548wG23i+tyN6TIHbGho8hMFXCPtKZlFl5a8hZ5Sq+qrlYpfL8z0t6kREllwVMVldIwtogyWXDEj9TY1ZBlHJ2x3m9iTjUBVbjKpQvYKBUNhaSYJwZt8KIl/yVgOTvduw8jkCMe/x0+RtoMy8F29koCFDuT939SBbbDRGSfF2qovnSc6Vh9tyrekysGrBybeVHMrN7au3mM24GdOHtgYBZ45ZmM8LfoOM9yNWf9SkOkhb0tmFh2LpXTQ8rDqjJdsMfKSmT+3drEY1pxE83dXL4qw+PU5Qta6pnXob3s5zqTjIN7hWBNwhjKljGksCwkbP4ViXneXHdXZUnLKiL3ky3jsWvHd8dDVp9oK3yx7NwO+GqLdEG8rcBCzgYmsqEdSu1QyxNetvKmABrq1ssrlt7TAzcK0YEPzmTbobQ6cjG+jzYuZE1PQeN2ZiO4qX3EauAZ1E58zuRvqw2jWWh+jFCkkd3eeZymFLw7Mo+mK8ukdcqtdq2UMCKiaGeTJnTbyJUzCJMcnnCeN6jkfdMMN4l1b1O4uAhuUR9poP8PpR+vcBGHKW8vmZGujOahMR7e5twTYSAkXuQea0/Ns6Ku+OSVJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(10070799003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(921020)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022115727099003)(261022075727099003)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHU5eEgxQkYxTWFGdjlXb2IvQUtJZ3loL043Q1VYaFcyaE5wNXprSmJhcTBO?=
 =?utf-8?B?VEJ4Wld6RjY2N2I2UmtOTGh4OVYrSDRpNEs1VGVMY3NWYUxuTW9Bcm41bWt4?=
 =?utf-8?B?c0ovNEtaL1k2RUtTa2ZJald5WG1IUDYxM0hub3BGL2NDb043clErVStuSlBX?=
 =?utf-8?B?d2FFS2hXcFVWV1dDUWp1YjJTV1UxUG1SSU9IcWZrOVNaS01mT0RwUVc5UllV?=
 =?utf-8?B?Zm9zcDRxbnpwV3VWLzBad0YrZmo5UlJ3R0czTDFseE1meEM3YU03VjRFc0Fv?=
 =?utf-8?B?WC92aEZpQTF1cUI1TjZnQ0xrNDFyWElRa09kakQrc3VtVFVGUkoxZytTT3Jq?=
 =?utf-8?B?ekNKOGVrNGdHWkVLZFcyazMzWnM2R1I5WHpVSjR5RHVYUXJCUnpwa1VLNWRG?=
 =?utf-8?B?SWNUYzBabjY4bnI2TXowL2FBMGgyMHdTVHFDYkoxTlRDODE2dlBWUFNSTllM?=
 =?utf-8?B?RDVsTnRwNk9MU2l4djdiMjNJeFBiYWNybVMzbi93M0FiTGg3Y1d2N3IwSUtL?=
 =?utf-8?B?SkpmQ2NjMmZ1a2hQdEc1RitPdEhsSkJDU2lwMjE5WCtLMEpmeUpOdnpRckd0?=
 =?utf-8?B?ZjU2emlEbTUxODhjZXV5aVhCbXFQcFVsVVJXY0QzSzFobm5jS2FxbG5sOGhZ?=
 =?utf-8?B?dVkrYlhnd0NLckhmY2E0ZlY3STA0UDR2aFl2WGVlQmVYaEFrRnFMNGRzUG5W?=
 =?utf-8?B?c2x0QUpNYUdEaG5lNTNxNzlPM1MzYWhpclFEMVE2aVA1bGlxTUlTeVFqdjNN?=
 =?utf-8?B?eDl1Z3hVQ01iSUx1WUhzd1pYeDJWaWtPSTc1SGh5U0xKc2doNytkMFN3NjNk?=
 =?utf-8?B?TzdLT1ArNWVPczNTVFRBLy9kaE5xWWp4UUJGSXhKN2I1cDlOQnFZRFQ2K3RW?=
 =?utf-8?B?L2ZuSFFQV3BFSGZtWkc0aEMxSHQxaSt0WUNINzJyc3BuRVNGaWh1RHNFMHMw?=
 =?utf-8?B?MDhMTm9kOGI1UnZDVHdvTzFVdjZWM1lIR0ZwbXdxNEV4VXVKeGRuSHZ4VjBt?=
 =?utf-8?B?dGJrZllRRDJaSjQxNjA3K0xtdS8wQWEwd2ZkQ2xoZjdyZ1U3QzJ2bkY1LzM5?=
 =?utf-8?B?YWZocVZRNTJIcExQOGhIMVZ0UkMrUHU2N0ZiSytTcTVDSmlLeVhkditmeTAv?=
 =?utf-8?B?NS9kZG9veHUydkhiQmp3VWZwdmtQeTNJZVFVblFIdWJTbThsNlZHNGxnQktr?=
 =?utf-8?B?QURPQmhVUjBvNzlBdHBpU3NpUjNmWXZtaUxnem5sTDRUeTdnM08zRzNUVzVV?=
 =?utf-8?B?Y2EzbnViSFlqMlJXKy9tNFRSV09hYnZBUll5MDQzUEpjdFQ3cWdOU0NsQXpF?=
 =?utf-8?B?dDNrb1dsczFqZDJzUXhzWHdWOFdoMEtDZXhNak5XT0w2TnM5ZllXdlRmRWRQ?=
 =?utf-8?B?Qm12YVlTZ2R3REkvVVBoN05BZTdyaUVyMnNQbElJRTRHV1NhZHo5NWlScnkv?=
 =?utf-8?B?ajRaaWRHY0hZcnJiZ1YxSXIva2xBWklmdk1SaHhSMWN1T0RJc1kyQWNOWlNO?=
 =?utf-8?B?SHI2ekMrUXhNM1FoT3BwNkdyd1ZhLzI1ajNzb3VtS1VjczhmVEJITWFDeFdS?=
 =?utf-8?B?TCtwK29RazJvaTNHa3d1NHVvc0FWdGprTTcvV3lRS2FVNXFNbmlCVEI0bDd6?=
 =?utf-8?B?dS9zMDVVU2w0anhSN2FSOVVsZFlwdlE2UEQwb2NYRDJUaTNRVG52WlNBbjlR?=
 =?utf-8?B?N1VDZkVRaHk1OUpCVWljWlFPajh1WEdLcm5uTGIySldsUDJrbGtuMUdZeVEw?=
 =?utf-8?B?WDRMd3VYNDNiaThOcE9PRXhQblNNdGs0N09DYmlZendSWWQvMDdmc0s0TFU2?=
 =?utf-8?B?VkFveUN1QXV0VUdvSyswdnBONGxnamxDVEF6bmx0NGJCUW9CODFsSFZYdjdh?=
 =?utf-8?B?elh3Q2d6T2NJb1FHSWxEcXhiS0FPaGRHOURrY2VaTkZPT1NjRUl3Y0EvMklW?=
 =?utf-8?B?a2p5bU4yQUI4dEhDL05iYU5NVUN2WjIvQVZmNTZvQzFBSXQ5VWt5L0hEMlVr?=
 =?utf-8?B?S3ZxWURnNUJtRnRNNEhaRytpMHpNSkR3Q1RIVWZRVitVMFp4enBseHNZMlcz?=
 =?utf-8?B?YklxMzROdGxMZXMxZEIxeTdLdEhqQlJ6Vmh5ZkpXeWc4SitJUFNUSnlqZE1V?=
 =?utf-8?B?anRtbUVVNDNMZUlmb200SVFtU0NCR2VqVy9wRUJhZHBTVG5HRUJvdXZ4S2t1?=
 =?utf-8?B?MXBvMnQ1ZVNjaXhVQjJ0WHVKZFZhN3VVdFVNZUpTaGFEVzd5UG9qTjBNeXNx?=
 =?utf-8?B?RStJUFdFVVJBcCtZWjg1UFlKRUtZS2NGc1hHcmNZZ3ZaaUp1OUhLZTJYQytN?=
 =?utf-8?B?MzF3R0c2TXA5R0FhSEVXdnphYjRNUEtSRndZSUZGNGxCV1NnTFdsanVmMnow?=
 =?utf-8?Q?ecsbDNt/dLzOZwQjILJ2rebNaUrRq82EWFisePteRbB+n?=
X-MS-Exchange-AntiSpam-MessageData-1: WUOuyXABpgJYfg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774f74cd-29ca-4ab7-2c00-08df3e3c185b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:33:13.9397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjeUsCIuQ+ZHQYpt2fmUbOLjNgbNwaDptJbhEt1uyNP1s4WiZbG/0NQuPjtc8GEYPOKWLSl/zwLtByiuRlWCVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999229
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use `SizeConstants` for Alignment that are implemented now.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs               | 10 +++++-----
 drivers/gpu/nova-core/fb/hal/gb100.rs     |  2 +-
 drivers/gpu/nova-core/fsp.rs              |  4 ++--
 drivers/gpu/nova-core/gpu.rs              |  7 ++-----
 drivers/gpu/nova-core/gsp/fw.rs           | 12 +++---------
 drivers/gpu/nova-core/mm.rs               |  2 +-
 drivers/gpu/nova-core/mm/bar_user.rs      |  7 ++++---
 drivers/gpu/nova-core/mm/pagetable/map.rs |  7 +++++--
 drivers/gpu/nova-core/mm/pramin.rs        |  6 +++---
 drivers/gpu/nova-core/vbios.rs            |  7 +++++--
 10 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index b0c0b8fe6008..5ceb7760c78e 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -219,7 +219,7 @@ pub(crate) fn new(
         };
 
         let frts = {
-            const FRTS_DOWN_ALIGN: Alignment = Alignment::new::<SZ_128K>();
+            const FRTS_DOWN_ALIGN: Alignment = Alignment::SZ_128K;
             let frts_size: u64 = hal.frts_size();
             let frts_base = vga_workspace.start.align_down(FRTS_DOWN_ALIGN) - frts_size;
 
@@ -227,7 +227,7 @@ pub(crate) fn new(
         };
 
         let boot = {
-            const BOOTLOADER_DOWN_ALIGN: Alignment = Alignment::new::<SZ_4K>();
+            const BOOTLOADER_DOWN_ALIGN: Alignment = Alignment::SZ_4K;
             let bootloader_size = u64::from_safe_cast(gsp_fw.bootloader.ucode.size());
             let bootloader_base = (frts.start - bootloader_size).align_down(BOOTLOADER_DOWN_ALIGN);
 
@@ -235,7 +235,7 @@ pub(crate) fn new(
         };
 
         let fw_image = {
-            const FW_IMAGE_DOWN_ALIGN: Alignment = Alignment::new::<SZ_64K>();
+            const FW_IMAGE_DOWN_ALIGN: Alignment = Alignment::SZ_64K;
             let fw_image_size = u64::from_safe_cast(gsp_fw.size());
             let fw_image_addr = (boot.start - fw_image_size).align_down(FW_IMAGE_DOWN_ALIGN);
 
@@ -245,7 +245,7 @@ pub(crate) fn new(
         let (vf_partition_count, wpr2_heap_size) = wpr2_heap_params(chipset, vgpu_state, fb.end)?;
 
         let wpr2_heap = {
-            const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::new::<SZ_1M>();
+            const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::SZ_1M;
             let wpr2_heap_addr = fw_image
                 .start
                 .checked_sub(wpr2_heap_size)
@@ -256,7 +256,7 @@ pub(crate) fn new(
         };
 
         let wpr2 = {
-            const WPR2_DOWN_ALIGN: Alignment = Alignment::new::<SZ_1M>();
+            const WPR2_DOWN_ALIGN: Alignment = Alignment::SZ_1M;
             let wpr2_addr = (wpr2_heap.start - u64::from_safe_cast(size_of::<gsp::GspFwWprMeta>()))
                 .align_down(WPR2_DOWN_ALIGN);
 
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index 612f70333c11..37b2ae762df4 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -80,7 +80,7 @@ fn write_sysmem_flush_page_gb100(hshub0: Mmio<'_, regs::Hshub0Registers>, addr:
 
 // This PMU reservation size is r570-specific.
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
-    cv!(const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap())
+    cv!(const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::SZ_128K).unwrap())
 }
 
 impl FbHal for Gb100 {
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 3a4a10487f33..637a00b2c951 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -20,7 +20,7 @@
         Alignable,
         Alignment, //
     },
-    sizes::SZ_2M,
+    sizes::SizeConstants,
     time::Delta,
     transmute::{
         AsBytes,
@@ -259,7 +259,7 @@ fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_info: &FbSizes) -> Result<u64> {
         if fb_info.pmu_reserved_size != 0 {
             offset = (offset + u64::from(fb_info.pmu_reserved_size))
                 // The 2 MiB alignment is r570-specific.
-                .align_up(Alignment::new::<SZ_2M>())
+                .align_up(Alignment::SZ_2M)
                 .ok_or(EINVAL)?;
         }
 
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index ac5305d7ff5e..d185e927233f 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -12,10 +12,7 @@
     pci,
     prelude::*,
     ptr::Alignment,
-    sizes::{
-        SizeConstants,
-        SZ_4K, //
-    },
+    sizes::SizeConstants,
     uapi, //
 };
 
@@ -568,7 +565,7 @@ pub(crate) fn new<'a>(
                 let buddy_params = GpuBuddyParams {
                     base_offset: usable_vram.start,
                     size: usable_vram.end - usable_vram.start,
-                    chunk_size: Alignment::new::<SZ_4K>(),
+                    chunk_size: Alignment::SZ_4K,
                 };
 
                 GpuMm::new(
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 75b98f24dea1..5c216d777dff 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -26,10 +26,7 @@
         Alignment,
         KnownSize, //
     },
-    sizes::{
-        SizeConstants,
-        SZ_128K, //
-    },
+    sizes::SizeConstants,
     transmute::{
         AsBytes,
         FromBytes, //
@@ -65,7 +62,7 @@
 enum GspFwHeapParams {}
 
 /// Minimum required alignment for the GSP heap.
-const GSP_HEAP_ALIGNMENT: Alignment = Alignment::new::<{ 1 << 20 }>();
+const GSP_HEAP_ALIGNMENT: Alignment = Alignment::SZ_1M;
 
 impl GspFwHeapParams {
     /// Returns the amount of GSP-RM heap memory used during GSP-RM boot and initialization (up to
@@ -209,10 +206,7 @@ pub(crate) fn from_ranges<'a>(
             bootBinOffset: ranges.boot.start,
             frtsOffset: ranges.frts.start,
             frtsSize: ranges.frts.len(),
-            gspFwWprEnd: ranges
-                .vga_workspace
-                .start
-                .align_down(Alignment::new::<SZ_128K>()),
+            gspFwWprEnd: ranges.vga_workspace.start.align_down(Alignment::SZ_128K),
             gspFwHeapVfPartitionCount: ranges.vf_partition_count,
             fbSize: ranges.fb.len(),
             vgaWorkspaceOffset: ranges.vga_workspace.start,
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 8a934c55169f..f53886f9ed91 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -317,7 +317,7 @@ pub(crate) fn run(
 
         let base = usable_fb_regions.iter().find_map(|region| {
             // Tests rely on this being 8 byte aligned for checking misalignment handling.
-            let base = region.start.align_up(Alignment::new::<8>())?;
+            let base = region.start.align_up(Alignment::SZ_8)?;
             (base.checked_add(SELFTEST_SPAN)? <= region.end).then_some(base)
         });
         let Some(base) = base else {
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 6e9384f06f43..2e8bd2a8ed91 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -195,6 +195,7 @@ pub(crate) fn run_self_test(
         },
         ptr::Alignment,
         sizes::{
+            SizeConstants,
             SZ_16K,
             SZ_32K,
             SZ_4K,
@@ -222,7 +223,7 @@ pub(crate) fn run_self_test(
         mm.buddy().alloc_blocks(
             GpuBuddyAllocMode::Simple,
             SZ_4K.into_safe_cast(),
-            Alignment::new::<SZ_4K>(),
+            Alignment::SZ_4K,
             GpuBuddyAllocFlags::default(),
         ),
         GFP_KERNEL,
@@ -299,7 +300,7 @@ pub(crate) fn run_self_test(
         mm.buddy().alloc_blocks(
             GpuBuddyAllocMode::Range(range_base + sz_16k..range_base + sz_16k + sz_4k),
             SZ_4K.into_safe_cast(),
-            Alignment::new::<SZ_4K>(),
+            Alignment::SZ_4K,
             GpuBuddyAllocFlags::default(),
         ),
         GFP_KERNEL,
@@ -311,7 +312,7 @@ pub(crate) fn run_self_test(
         mm.buddy().alloc_blocks(
             GpuBuddyAllocMode::Range(range_base..range_base + sz_32k_4k),
             SZ_32K.into_safe_cast(),
-            Alignment::new::<SZ_4K>(),
+            Alignment::SZ_4K,
             GpuBuddyAllocFlags::default(),
         ),
         GFP_KERNEL,
diff --git a/drivers/gpu/nova-core/mm/pagetable/map.rs b/drivers/gpu/nova-core/mm/pagetable/map.rs
index 77431c509a89..f7774b9cc972 100644
--- a/drivers/gpu/nova-core/mm/pagetable/map.rs
+++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
@@ -17,7 +17,10 @@
         RBTree,
         RBTreeNode, //
     },
-    sizes::SZ_4K, //
+    sizes::{
+        SizeConstants,
+        SZ_4K, //
+    }, //
 };
 
 use super::{
@@ -84,7 +87,7 @@ fn alloc_and_zero_page(mm: &mut GpuMm<'_>, level: PageTableLevel) -> Result<Prep
             mm.buddy().alloc_blocks(
                 GpuBuddyAllocMode::Simple,
                 SZ_4K.into_safe_cast(),
-                Alignment::new::<SZ_4K>(),
+                Alignment::SZ_4K,
                 GpuBuddyAllocFlags::default(),
             ),
             GFP_KERNEL,
diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
index 7f89c093d591..c83b1681d241 100644
--- a/drivers/gpu/nova-core/mm/pramin.rs
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -19,8 +19,8 @@
         Alignment, //
     },
     sizes::{
-        SZ_1M,
-        SZ_64K, //
+        SizeConstants,
+        SZ_1M, //
     },
 };
 
@@ -103,7 +103,7 @@ fn drop(&mut self) {
 
 impl<'gpu> Pramin<'gpu> {
     /// Alignment required by the PRAMIN window.
-    const BASE_ALIGN: Alignment = Alignment::new::<SZ_64K>();
+    const BASE_ALIGN: Alignment = Alignment::SZ_64K;
 
     /// Creates the window manager for the given VRAM region.
     pub(super) fn new(
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 9c214b9f4dd9..a2d2d170b501 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -11,7 +11,10 @@
         Alignment, //
     },
     register,
-    sizes::SZ_4K,
+    sizes::{
+        SizeConstants,
+        SZ_4K, //
+    },
     sync::aref::ARef,
 };
 
@@ -291,7 +294,7 @@ fn next(&mut self) -> Option<Self::Item> {
 
         // Advance to next image (aligned to 512 bytes).
         self.current_offset += image_size;
-        self.current_offset = self.current_offset.align_up(Alignment::new::<512>())?;
+        self.current_offset = self.current_offset.align_up(Alignment::SZ_512)?;
 
         Some(Ok(full_image))
     }

-- 
2.56.0

