Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3F9CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF7C710E38D;
	Mon, 25 May 2026 13:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mZVWYmyT";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D353910E389
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6lg7UvLRxq0NkmpTYNIXOle5Tj7DXPbHL7juLNGpW+o21nmpU66nsjVB6E6GX55lGsrm8J51IOXNeNRzTqQoJKE4ECVNczJcKqBcsEz48vO5tkHlgmNG+8++kAd5hSEuILYHypDVRng1xVw+5biJxcysXlppmULmLGn0VJOS++Lg2y/5vdv1Qvdb6a2e0ACNR24s9Zf561fm2cF81RjxxHbuEZlU28oijiV7JkBIBFQkvhRrT6t/vTqgicFv1ckrE+75SSHY3/zOO/k8Z+TvShjwYe01kYA3PFFd8TQUPdEbsbwdQKc3z0ZiInlr9vkNZsx3qbTf0WT3FdjETnMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaxYNiCObU+skCYh3NazEDXcaQUUrYOkr/QyrxE+EB4=;
 b=XrxXJH7A34UFppkgymQcFerdBNcA3zd5UfrLFBouWt7rWLF3gtsZGT8GFTXV/1EJt6s9i/0JDXBrXysl1jphJZhkqOOMLs7QWWAoLlharoxuBW0KTg9Fy3CQappySdqM7rXVsnC9jykhTSHb1bqDeliJBZj4SXTCTAfxI0QqZ1Ugr7YVh61tpksoCucqimN8awggYT+IK3NQ6rWWnfBIBOLpOAEch25bVOz4sG3iH87kyVeHsvsUwbTM6Kyx+MfvoIEq5x9NdmOq5cKOjwPV8+XFvafJK4PFWq6o3okmw1Klkk+Vcts2inF/9/6w76XM7JI0xfUqvoroT57XOmcTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaxYNiCObU+skCYh3NazEDXcaQUUrYOkr/QyrxE+EB4=;
 b=mZVWYmyTyagBHTXEI0WLhpstfLMV9y5EoMuU8b18hwgkg3QSkvc3Ocj878UxbudapFVTBmadlRtcY/1c7j3QyGMLmdNh9MzFcttpHkxCdxNUKxHq11xatwguYKXS79mhR1sALqIgk/YdwEr1GnxMyZ5qkUs+opSsEhRBgTPqPieW/ZwvbYo9xS3Shagepmh0DvM/58Tck699seTJ/GPg+i2xZ2Tkp7idpsbjNiCWOEnqhY2Ycg8vtNIubChP6kiqNUAux3ilCe7wAxHekknFO0hrTeKufmJR2159oDM2AAIqTlQFgxjJqhQvw58Xqoq6YbAyPfGa0no7ReOc98obRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:58:52 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:58:52 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:34 +0900
Subject: [PATCH v5 16/22] gpu: nova-core: vbios: use single logical block
 for the FWSEC section
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-16-e5e455251537@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0121.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 0890a931-e684-4392-4eb3-08deba65c0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: XvL62vP8TuO7f2+723yYo67GSc/P3Z3KAji/uQFnly0H86I5jlSrjiaAmt2ELi4YW39iy8jNy6cdo/x2BxM7zK9UiuVqCnhKPrXHz/L0f8JiTj8xJb4J8AYToihUfWmJERbGe0Oo9sMo+LXKXI8uEGD3EVz4OKw8nnPQEw09aqwwIeG1GjcziOzlepZyb9fgQ3nBYKo+sfLLi8IO8Jod4fSmhwu7NPCwZIrynKGrPN2GyfPYcLFyTPlY6d5AG4jkf8/zz0MBXNF15q2VsMJcquDDAI47X2WKiIozWgmiBkHmWhUrTBgm0lKRPpJr3JhV6BCLgySgGAXuPaFG0K6TRbyLn5AsWbzKt/FGGNuxgwHtPfz2izxDkhrA+Tl4iKzUA8odHnX/3gpEyFPj2no5PKdzAuslj2N5MhUJJYl29Cy2N6vcY7YkqwROQclUCmA9xSmmxd2tHb4MhDNWR1AGXvS5n/ObcwGt4/RoAv3fvRSct/WXqQ82cWj+W48vU8h+Z1IUkRMKEGbmyBiU5a6AxRL6Q7TaVeFq4TZyCd4S+O72lhdKdIuIe9q2OoWku7A36LUIarbnn+uzeHNb3X1NJT73DX90WlA6sDvDfFCkWWq3aBVgUsEi9nVVS12MpE0TjADF6D2DZ6A1oZ+CYVi0AINd6rxnkGbro10Ip5Vqe3GFU86XNXxMI0RrMXcePLsw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3BuY056cFBhaHZPUkNQRmUrbytiaW9hZ21uYnNNTjYvYmZyRXNXaTRLMGdV?=
 =?utf-8?B?eTdqaHdwQnFxcjBFYWhLTGRUZlBRZC9vUEthWS9pZ1U2RHFjT0Z3bzExSTZj?=
 =?utf-8?B?VUpFd2hMeU5BYlRYUXFMaTEyaUdGUU5mY2Q1bVU0VkJGRmxpTG93SGZPdlhj?=
 =?utf-8?B?dW5wRzU2Tll6Mmk2bDkwVGZCNTY4Yk9QL2hybkxjWDhMT3JIZUZUSVUvUzZD?=
 =?utf-8?B?Tkpqdko2dHVXaCs3SUFwbm83S2hNZjd6aFI1K1UweG1ITmplZWhCbHRJNzBR?=
 =?utf-8?B?ckhJcy95a3ZqdDNLeVl5dnRucXM5K3Q2U1VrdTRCQ1NrbzNsZEZWMXVwRkM1?=
 =?utf-8?B?ZE1JRkEwanpuYXVpTCsvM291ME54cFd2WXBFYktDM051TFhkWE5QcTZ4ZUt6?=
 =?utf-8?B?Ylloanc5ZjJYVml6WnpJbHF3dGJOUU1jWURIYmt6Y0QvcEt5bGQ2REJLcUtj?=
 =?utf-8?B?NjFVZG9iYVYwaVZidVpEdnFaSHpCaDB0c2Jna0ZzUG1RSm5nQWRkVk5LL09r?=
 =?utf-8?B?RDIwTXpQWTZMUWo1OEhONUFrdHVWSnQ2U3drTjlyT1poam5BUGt2UU4vL2lU?=
 =?utf-8?B?clEwdElEWmhMTUVuUjFWaFJTQUxYSXg3T3NISmhFQ2lrMWZTd3lUalB2VjJ5?=
 =?utf-8?B?aWRwUmlaNEdsSEhUV0cwdk1HckltZWsrMk5GcVFFWG1xU3JuYVhRemtQYi9s?=
 =?utf-8?B?cTFZRm42UVJVelp6NSt6WDc0ekRDL1V6VmxxOG40VzBKNUxDSjEwbENXQVZ1?=
 =?utf-8?B?OGxMaytPclZTRXhMdkZ1VEdpTEVMRVhPK3k5SnEza2tsbUU4RVZiRnhUZXg5?=
 =?utf-8?B?KzFVSjNLT1N1UzAzVUJpYnR0cGhsZi9uNUEyNHFGNlQrZHBBMzRqZ01CY2p4?=
 =?utf-8?B?NmN2dzNhSFQxODFiRWpERzZoY2l2SXprdGRzQmwySk9CQ0JaZlRTbDRudFQ2?=
 =?utf-8?B?eUVKVXcrQWd3NzB2REoyTVc3blp5VnlLczZ3OEFKbU56VzFEcm5ycGJBR0FR?=
 =?utf-8?B?ekhyUXN6b25Va3BPMC96ME51VGc4cTdrRXIrTncvemt2aFZWVzZSQVFhMGg5?=
 =?utf-8?B?TldUSXcrMGl6MnRRMFNxRTlUZmlyU0tYRHZ1N2dVVnZadDJzdDFkYW9SSy96?=
 =?utf-8?B?Tk5Obmp3VGkrd3E0Q0FhZE5rSHhZRjVEcnZiS2FNYXpyN1FiQk1hbTBta0tR?=
 =?utf-8?B?NC9mNkx3R2NBRk5nNkdKVFFDVGNNY0tYMHowSnRRQi94MFVSdEtnQi9zcFk0?=
 =?utf-8?B?M1NDL3ljSURxWVV5WHpKYWtSVDZ0eXZVbVcwSXhrVjlJQVRsNFBWcURzdnRj?=
 =?utf-8?B?NG5FMDFHbmxkZU4vVjNSSm0rc1dGVHhwakFkcjhlZjRYV0pNdVZKQ2F5cWNz?=
 =?utf-8?B?aklqb0swNm94OU5tcUJLWUovTHJQbkVWVGxjdE5kSE1hUHc3WUttWWFBZWx1?=
 =?utf-8?B?dytxckhjenlpa09VNUtDeDlpY216NGtrOXIzK011RU9tK0g0Y1NQZ2dBb2xI?=
 =?utf-8?B?eTVodUt3d2lQbUFuMjZLVEk5YUM1dWZDMWIrZk1tZVVKcU1NNGN6RnFMZUNE?=
 =?utf-8?B?eldmYVlCZW9BTjNUd3V2OFU2KzdEbGtWd2drRmgxaW9pQndxR1g5a3BhUFJD?=
 =?utf-8?B?T2RrTnhhTkxKUHN3dHZIN0xlTkxOM01mRnFPZ1llZURaOXkyYmtOcFdnM3VV?=
 =?utf-8?B?THpaNG5ZdGpPekx5ZE1YSmk3eEFMLzY2eTQ2UGFNQ0tRc3RidEZjYXFMbWNI?=
 =?utf-8?B?OG5nVkR2Q1FJRUt0S29RaEFjaE94MUZQZFU1TWQySms4azVSTmc0ait1K2F0?=
 =?utf-8?B?bzk5UlFXY2h0dUJEcU5waml2VHpLL25RMFd1ekpCRVZ4UEVKaDhUSHpyMzNm?=
 =?utf-8?B?RkRYb3VoS2tNZWlMR2xKK1JWNjN6cWJZajRycVpmZjNhc09oYTJuZDU3b2RZ?=
 =?utf-8?B?NE9ZZVhGOGsrNUhwdVFlSEtIZ0dSbFh3WndJbXJnWHIwcEJLT2dOMUJkVE5G?=
 =?utf-8?B?WUc5bzhoWWRxaFJrTzhlemQzOXVNNFIyQTF6dXZtSjl5ZWRNbkJyblJ4NXdn?=
 =?utf-8?B?YkE5eFZ4OStjTk9vMnQ3SFZZd08yTWZ1VGpzUE1HcmtqaVRQZEZuWndQTDBr?=
 =?utf-8?B?c3UwaUVDRUpsZXVPMmp1ZUpLUjZPdWdHVVk0MEM4S0J0SVJJeEQ5TUpmSU9m?=
 =?utf-8?B?cTUrYTBseHFLQ1hNUFBRZE9PSjMwZlc2Z1pBSzlHc0F5cGRRcm9tTWQzVkJs?=
 =?utf-8?B?cHhQTUlmWDFyZkJqWVlJVWJYbjZLNXdiZXdwR2VUY2lCZmgvK0xGcUMzNksx?=
 =?utf-8?B?Vzd2dVhrcDhDRGhUZ3N6WjVLOW9NQnVwRFF2em5nRDVDT3oyYWpzYkxBM2xu?=
 =?utf-8?Q?KuybkSCWdbBcjZxDcRd+xS4aZhiIVRJHwbxxrgA9PE/3s?=
X-MS-Exchange-AntiSpam-MessageData-1: Tuutlv5G4qciqg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0890a931-e684-4392-4eb3-08deba65c0c7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:58:52.2949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONFenGJsT+sBtTs+W8EcdUu818Pd5sYt20kzf9y1R0B8zYTbuGRvZ8LcBG3uConqnrqJk8N/KrICBcLtMR+UHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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

Currently, FWSEC takes the first image and the last image. Treat the
first FWSEC image and all following image data as one logical block
for building the final FWSEC image. This avoids explicitly tracking
two FWSEC images.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 99 ++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 82811e42e858..5266e15793cf 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -84,7 +84,7 @@ struct VbiosIterator<'a> {
     /// progressively extends. It is used so that we do not re-read any contents that are already
     /// read as we use the cumulative length read so far, and re-read any gaps as we extend the
     /// length.
-    data: KVec<u8>,
+    data: KVVec<u8>,
     /// Current offset of the [`Iterator`].
     current_offset: usize,
     /// Indicate whether the last image has been found.
@@ -177,7 +177,7 @@ fn new(dev: &'a device::Device, bar0: &'a Bar0) -> Result<Self> {
         Ok(Self {
             dev,
             bar0,
-            data: KVec::new(),
+            data: KVVec::new(),
             current_offset: vbios_rom_offset(dev, bar0)?,
             last_found: false,
         })
@@ -315,8 +315,7 @@ impl Vbios {
     pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
         // Images to extract from iteration
         let mut pci_at_image: Option<PciAtBiosImage> = None;
-        let mut first_fwsec_image: Option<BiosImage> = None;
-        let mut second_fwsec_image: Option<BiosImage> = None;
+        let mut fwsec_section: Option<KVVec<u8>> = None;
 
         // Parse all VBIOS images in the ROM
         for image_result in VbiosIterator::new(dev, bar0)? {
@@ -330,6 +329,13 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
                 image.is_last()
             );
 
+            // Once we have found the first FWSEC image, grab all data after that as the FWSEC
+            // section. This is indexed as one logical block to build the final FWSEC image.
+            if let Some(data) = fwsec_section.as_mut() {
+                data.extend_from_slice(&image.data, GFP_KERNEL)?;
+                continue;
+            }
+
             // Convert to a specific image type
             match BiosImageType::try_from(image.pcir.code_type) {
                 Ok(BiosImageType::PciAt) => {
@@ -338,13 +344,7 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
                         pci_at_image = Some(PciAtBiosImage::try_from(image)?);
                     }
                 }
-                Ok(BiosImageType::FwSec) => {
-                    if first_fwsec_image.is_none() {
-                        first_fwsec_image = Some(image);
-                    } else {
-                        second_fwsec_image = Some(image);
-                    }
-                }
+                Ok(BiosImageType::FwSec) => fwsec_section = Some(image.data),
                 _ => {
                     // Ignore other image types or unknown types
                 }
@@ -352,10 +352,8 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
         }
 
         // Using all the images, setup the falcon data pointer in Fwsec.
-        if let (Some(second), Some(first), Some(pci_at)) =
-            (second_fwsec_image, first_fwsec_image, pci_at_image)
-        {
-            let fwsec_image = FwSecBiosImage::new(pci_at, first, second)
+        if let (Some(pci_at), Some(fwsec_section)) = (pci_at_image, fwsec_section) {
+            let fwsec_image = FwSecBiosImage::new(dev, pci_at, fwsec_section)
                 .inspect_err(|e| dev_err!(dev, "Falcon data setup failed: {:?}\n", e))?;
 
             Ok(Vbios { fwsec_image })
@@ -703,7 +701,10 @@ struct NbsiBiosImage {
 ///
 /// The PMU table contains voltage/frequency tables as well as a pointer to the Falcon Ucode.
 pub(crate) struct FwSecBiosImage {
-    base: BiosImage,
+    /// Used for logging.
+    dev: ARef<device::Device>,
+    /// FWSEC data.
+    data: KVVec<u8>,
     /// The offset of the Falcon ucode.
     falcon_ucode_offset: usize,
 }
@@ -713,8 +714,6 @@ pub(crate) struct FwSecBiosImage {
 /// A BiosImage struct is embedded into all image types and implements common operations.
 #[expect(dead_code)]
 struct BiosImage {
-    /// Used for logging.
-    dev: ARef<device::Device>,
     /// PCI ROM Expansion Header
     rom_header: PciRomHeader,
     /// PCI Data Structure
@@ -722,7 +721,7 @@ struct BiosImage {
     /// NVIDIA PCI Data Extension (optional)
     npde: Option<NpdeStruct>,
     /// Image data (includes ROM header and PCIR)
-    data: KVec<u8>,
+    data: KVVec<u8>,
 }
 
 impl BiosImage {
@@ -795,11 +794,10 @@ fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
         let npde = NpdeStruct::find_in_data(dev, data, &rom_header, &pcir);
 
         // Create a copy of the data.
-        let mut data_copy = KVec::new();
+        let mut data_copy = KVVec::new();
         data_copy.extend_from_slice(data, GFP_KERNEL)?;
 
         Ok(BiosImage {
-            dev: dev.into(),
             rom_header,
             pcir,
             npde,
@@ -837,7 +835,7 @@ fn get_bit_token(&self, token_id: u8) -> Result<BitToken> {
     /// treats the PCI-AT and FWSEC images as logically contiguous even when an EFI image sits in
     /// between them, so subtract the PCI-AT image size here to convert it to a FWSEC-relative
     /// offset.
-    fn falcon_data_offset(&self) -> Result<usize> {
+    fn falcon_data_offset(&self, dev: &device::Device) -> Result<usize> {
         let token = self.get_bit_token(BIT_TOKEN_ID_FALCON_DATA)?;
         let offset = usize::from(token.data_offset);
 
@@ -852,7 +850,7 @@ fn falcon_data_offset(&self) -> Result<usize> {
             .checked_sub(data.len())
             .ok_or(EINVAL)
             .inspect_err(|_| {
-                dev_err!(self.base.dev, "Falcon data pointer out of bounds\n");
+                dev_err!(dev, "Falcon data pointer out of bounds\n");
             })
     }
 }
@@ -942,59 +940,38 @@ fn find_entry_by_type(&self, entry_type: u8) -> Result<&PmuLookupTableEntry> {
 impl FwSecBiosImage {
     /// Build the final `FwSecBiosImage` from the PCI-AT and FWSEC BIOS images.
     fn new(
+        dev: &device::Device,
         pci_at_image: PciAtBiosImage,
-        first_fwsec: BiosImage,
-        second_fwsec: BiosImage,
+        data: KVVec<u8>,
     ) -> Result<FwSecBiosImage> {
-        let offset = pci_at_image.falcon_data_offset()?;
+        let offset = pci_at_image.falcon_data_offset(dev)?;
 
-        // The offset is from the start of the first FwSec image, but it
-        // may point into the second FwSec image. Treat the two FwSec images
-        // as contiguous here and subtract the first image length when the
-        // target lies in the second one.
-        let pmu_lookup_data = if offset < first_fwsec.data.len() {
-            first_fwsec.data.get(offset..)
-        } else {
-            second_fwsec.data.get(offset - first_fwsec.data.len()..)
-        }
-        .ok_or(EINVAL)?;
-
-        let pmu_lookup_table = PmuLookupTable::new(&second_fwsec.dev, pmu_lookup_data)?;
+        let pmu_lookup_data = data.get(offset..).ok_or(EINVAL)?;
+        let pmu_lookup_table = PmuLookupTable::new(dev, pmu_lookup_data)?;
 
         let entry = pmu_lookup_table
             .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
             .inspect_err(|e| {
-                dev_err!(
-                    second_fwsec.dev,
-                    "PmuLookupTableEntry not found, error: {:?}\n",
-                    e
-                );
+                dev_err!(dev, "PmuLookupTableEntry not found, error: {:?}\n", e);
             })?;
 
         let falcon_ucode_offset = usize::from_safe_cast(entry.data)
             .checked_sub(pci_at_image.base.data.len())
-            .and_then(|o| o.checked_sub(first_fwsec.data.len()))
             .ok_or(EINVAL)
             .inspect_err(|_| {
-                dev_err!(
-                    second_fwsec.dev,
-                    "Falcon Ucode offset not in second Fwsec.\n"
-                );
+                dev_err!(dev, "Falcon Ucode offset not in Fwsec.\n");
             })?;
 
         Ok(FwSecBiosImage {
-            base: second_fwsec,
+            dev: dev.into(),
+            data,
             falcon_ucode_offset,
         })
     }
 
     /// Get the FwSec header ([`FalconUCodeDesc`]).
     pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
-        let data = self
-            .base
-            .data
-            .get(self.falcon_ucode_offset..)
-            .ok_or(EINVAL)?;
+        let data = self.data.get(self.falcon_ucode_offset..).ok_or(EINVAL)?;
 
         // Read the version byte from the header.
         let ver = data.get(1).copied().ok_or(EINVAL)?;
@@ -1012,7 +989,7 @@ pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
                 Ok(FalconUCodeDesc::V3(v3))
             }
             _ => {
-                dev_err!(self.base.dev, "invalid fwsec firmware version: {:?}\n", ver);
+                dev_err!(self.dev, "invalid fwsec firmware version: {:?}\n", ver);
                 Err(EINVAL)
             }
         }
@@ -1027,15 +1004,14 @@ pub(crate) fn ucode(&self, desc: &FalconUCodeDesc) -> Result<&[u8]> {
         );
 
         // The ucode data follows the descriptor.
-        self.base
-            .data
+        self.data
             .get(self.falcon_ucode_offset..)
             .and_then(|data| data.get(desc.size()..))
             .and_then(|data| data.get(..size))
             .ok_or(ERANGE)
             .inspect_err(|_| {
                 dev_err!(
-                    self.base.dev,
+                    self.dev,
                     "fwsec ucode data not contained within BIOS bounds\n"
                 )
             })
@@ -1053,9 +1029,9 @@ pub(crate) fn sigs(&self, desc: &FalconUCodeDesc) -> Result<&[Bcrt30Rsa3kSignatu
         let sigs_size = sigs_count * core::mem::size_of::<Bcrt30Rsa3kSignature>();
 
         // Make sure the data is within bounds.
-        if sigs_data_offset + sigs_size > self.base.data.len() {
+        if sigs_data_offset + sigs_size > self.data.len() {
             dev_err!(
-                self.base.dev,
+                self.dev,
                 "fwsec signatures data not contained within BIOS bounds\n"
             );
             return Err(ERANGE);
@@ -1065,8 +1041,7 @@ pub(crate) fn sigs(&self, desc: &FalconUCodeDesc) -> Result<&[Bcrt30Rsa3kSignatu
         // sizeof::<Bcrt30Rsa3kSignature>()` is within the bounds of `data`.
         Ok(unsafe {
             core::slice::from_raw_parts(
-                self.base
-                    .data
+                self.data
                     .as_ptr()
                     .add(sigs_data_offset)
                     .cast::<Bcrt30Rsa3kSignature>(),

-- 
2.54.0

