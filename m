Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D110CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E6D10E375;
	Mon, 25 May 2026 13:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="M89I04v+";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 600B910E375
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRhDwQJM2TeOlfSElc2T8XZKswwZ3Z7iCnizcX7wUrhcBo0GpgGA2luP1fGdiKYPr4bdfJDQbvODj9KuIYSDKL7p55QW3IpieSdQXemeP0lWJT247TyW5PtYSFN2xGrNkRQVwN/+cwWotX8Cp5yDNjUnsxsP6oeJDht59nzQtRm5QATneeeBC/5ZGBKx+XASicpcGSUBPaGH9BM+B8Bht4b2gAitOyE8su1EH7wJZM3yME59NQrNJwGIMAsyqfLcaBiZQqu/SD/VDMqGs2OzNT1BBcy0vvMLTWJIut3c84XiEbqc2DLHRffVAD42t2PMfQlZ04p9GALjWM4tnCXWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myl/x9fzSJBQ0R2mDzg2R2G0SeM7YEBoke3eDTQJhNg=;
 b=PsFa02VHVnY+E0C2cMw5yPsW6TozwAWVHhA8xkQH+GdFCbJuNXWJ8gTqLUJApj/vmhFdP6zrnQkKWilzdU58rnn+B+jd4ayKLNmSr25KnKFZNaa9Q7Bcc2lMttOXlTQzmJxtR9Vfv/JvzJ0NN6BRsRMwxlZ+l3WDn+/3s6JzOFxHuFx9TQzihU06e27NH08mJ4hZwjHcEzDJRnb58Hn76ef3FroImhtbhd/IWfcL+zX6o8NMnn4I/RG8fMkG+g/o0Px2IRD1njdwj1QvV4uBS6qdZeBciza049Q+WmwFUJrnLVSV/oMc4WuW+EcXc0BTQfrxzdcLywomM1R7B3u05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myl/x9fzSJBQ0R2mDzg2R2G0SeM7YEBoke3eDTQJhNg=;
 b=M89I04v+/3T9RFYVQLbvhuMsmoUK7uXxC9iJS5hIYXWUeUs5J1EsENufjm8TZDVqSm+xH23iGOC9TVxoV4UFsa0d7lf9WGKR+BapSU6TqxdPGSA6OB4uf5sR1mgUqe+oc+zOKHXXkt0TA5TRbY/976Cf7n6Ne3i8FUJMDk7YYLLsapqRbpO6vccYRcs6rFhoavkQ99vp1SwjpxfjpHaI6DLBrP80QaKD5wym2ZCk6yIOmmjeALS0zrTNs4rqBvtE+jBkKWL/vIwC4t06regCgQ0FAt1/y/kj0grxT8otR544aE4Hv6eEh/1A18YyWMyIcDePhhaN5RgqyPAhUvh8OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:58:07 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:58:07 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:24 +0900
Subject: [PATCH v5 06/22] gpu: nova-core: vbios: use checked access in
 `FwSecBiosImage::header`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-6-e5e455251537@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0079.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f930e5-e648-452b-e2f1-08deba65a607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: Ri9gtJMHcZP58EbfcFcQdJEwZZ/mXPDVF5xL0mYbacSou0+d1mUWqiK4ZYLD8eqnhjGJiKm4ql6BsltEffTPeA5xucApEbQXRqo5wf2zbVF58U8qQ8iNfOYVAH26ACx5Iq2x4Wu56qFVldNgsY3kdCK7aoyGUwM6kNble2NyPNahUcieIKiEZNT7fiuj8zGA5p584PNCmNfWgkRue166hwS8XvWt5H58h7Rx+W0NV9KvDR0/HvfDNkdGcHllPl6licIXHdnvSP7PsqF0FvBfJBWZBxYS9bIQoNjlmP99ZP0OxdB6JhJybOLY6bKwmvcE/JuQowdddtHs/cPHddrvltb0yUolxY/aT1QNoi+SAQ3A7zKOiL/S7DDDjKuFvU6JSmksfYThuU6Zl5DEnshB+wI70wA3uZcGmhgDyKu/W36WbJ4vdGbcbh4varbjQ2K9zH2pVCedUfXbHdXpZPkPI/MtQHFzdJ2aVRLENePuy8RD6eg59554QVBN0odeBl+HUCGGeNHPL5ddqcnlPVtGtA+hWkymBEFTJOgFUockKLwbIHphb12DT7R3E2giOXTvJfSLWQ/boHfhXBDyEmXTfsPsIjVdFnCLABwXhovB9zkyRJLwOghXCAh5Wq+exVJFNyFyYUc3GfzUXPj8ELtS4YrH9IjyhN7zzA2sM3utKHxIY8q38NqLy7gvt2uHw4GQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEppMnhLL05EeWlXTWNmYlVHQ3ZKVWlScWYrQ1oydElEa25ydXhZeUxtcW1z?=
 =?utf-8?B?amJaVDk0T3pSUVpicTNqc1M2RTZEOXNXTS9lZzFwcFVOMVNqY1c2S1lTemN6?=
 =?utf-8?B?K1JLZWxoUTl0TDdTSnZWSDhEWm83OXVJSVIvWG1wUnNtSURVdkhTWDRLbVpq?=
 =?utf-8?B?ODhKZHd6UzZrK3Y2NzFtOG9YMkM1MmRCRUVMV2xFZTF1amFvRDNhZldldUh4?=
 =?utf-8?B?MzRnTXVSaUpkdDhWVWp1SVIvUEFTbFRJMitidEw3cVd6K3Y2ZDdvTlh3OEg1?=
 =?utf-8?B?bW81aE42R2x0YU5EV0pvd2lTaWhvUEV1TEFxNHY0eXVTeHZ4eVZaeHhGbUta?=
 =?utf-8?B?bWtNQWFQY0xFZyt4aC9yY1h2eFdXdE5mb21uTHdmbnpvM1M4ZUdaclNjWW0r?=
 =?utf-8?B?U1RwQlZnMDc0ZDNJTU5nNHJxL01BL1dIdVl0d2E2TmxvZkllWXh3RlhMWklw?=
 =?utf-8?B?MHdIclJWb0o2UlFPamFaMXZQS0JFZlM3MEFBT0YyKzRZYktIeUo4MG5hT09V?=
 =?utf-8?B?a01CcTM5cjB1L0E2NSt0WXhhUUJZVmg0Z0daQXNnRi9iRldjUElCTUlaeHVt?=
 =?utf-8?B?WlE3QjFpb201K01zS0dpbDNObUVFYXEzRzM4RThSL1BNZXBKaWlPdllJTmpX?=
 =?utf-8?B?azBiUDdOMUNaN0tSQVlTelNQKzZsbHRPeVZsc1dkWDBFVDVaY0I4UTh1T0xo?=
 =?utf-8?B?dUcxRXBZeWZDWnU5M3AyNDZwM2ZrRzZ0anZSWnptUGhNdXF3ZGNYRnNDdTlW?=
 =?utf-8?B?TDIwUDVMV2dDTXVnNkE2KzZXR1pJcms3dzN2WjVqRGxnWWZwWXM3SVowczRR?=
 =?utf-8?B?cG5lY2JqanVFOTMzL2s1V2tkU3RlUHVFNVAzd0l1RWdHampFS1o2dXcvbGJn?=
 =?utf-8?B?bThJRStpR3pNNVNJcVV2d0k1a1BQVC85a0cxR0xlcGlvOU5KVzZ2ZUVrdFRh?=
 =?utf-8?B?TzliTVlpelptNFZUUTlUQmpGbmRGd0RiWVQ5S2NZQ29jZFBIWDF5RGgzck4w?=
 =?utf-8?B?V2pvMlgyeXEvM1k0aGNkaWxwVVhQUXBsVkc0RUJTaDVsNDFlVjVrMzFVT3Jh?=
 =?utf-8?B?M0ZIdW5IVUYrT2tTVWFESmlpZ2ovZm4ydHAwQlc3TlJUamRicUJSNldXdkls?=
 =?utf-8?B?NnNmcjVsTEp1SmdaVldaRVhDKzcwT0FWdlBmYmVpS2gwdDFaeFJ0d1AzaWpo?=
 =?utf-8?B?aUR1ZGkreUhZRmJmblRqbjJycUVWWENHUkRwSEJRNTJSYXJQY2ROVndzS3lP?=
 =?utf-8?B?dmJyc00rMXBKelFTWjQ1RkswSEdkdE9NWHRYTVNRMU1iV25kTkRodVZOVE4w?=
 =?utf-8?B?SW1xNmIzWEl2SHlJcVNmZm5Hc1Q1YVdhUjdaMVZMMGRJTTc4MjdGVEEzbjlU?=
 =?utf-8?B?VW1sbmFQTVpEb0RkQ0lxT0FqRjRkWVptMFV2cThqT1VWYnk3b093NWVtc25m?=
 =?utf-8?B?RktBWWtTUklPZy9nWFZ4ZHJNRU5Ua1U0Wjh0d3hmVlpmWDVPdy9XbVdzOHFD?=
 =?utf-8?B?cDNwSGhlSi9Qdks3UTVLRkkvMmR6bzdrdVJJb1NkQVRtMzF5ZXFOR1ZZWE50?=
 =?utf-8?B?OWduMUhGSDdLVGY4WEJMb3l1OUNuVXdUekdscXRWSlh2V0ppTXhQWWZaWlpT?=
 =?utf-8?B?NC9SR0NFZHc4TnZ6QUZheWFsS0RqMStnck5GV21kWHRrVDI0MEpZcXZXd01J?=
 =?utf-8?B?ZSt2VlFndDh0NzFlNUlCd2RJSTN6b0I0aWRBeUhXU1JCczh1M0paYk5ORDFM?=
 =?utf-8?B?czRzOU5yaWIvL2ovYnpXdWY5MGJxYWlESzlmdDk2amFGUDBpZzg0eFp3M0U2?=
 =?utf-8?B?NkhqKzN1QUZidTBCc2I2MllyU2JBUmpwOTRjK01OUkRML0hvWDFSc1cyK3Nn?=
 =?utf-8?B?bzIwTld5SlNMeGZvdWZDdXlNMUVUSlRYMmNOZThwWHVJR0RDK1lGVDBKdi93?=
 =?utf-8?B?OG1XRDU2M2JxbzJBVHhzcG45UzlJMnFsMDZYUjRoYzhWejc5OWdwSzdEM08r?=
 =?utf-8?B?K1lRWEhUc3Q5OERrYjhKRklpUDJKSGVrWUtnaVBjSmhPSlJFNEQ5eFNiV2w2?=
 =?utf-8?B?WDZvbm4rb2QxTDZyQXp6VVB6RE1ZeFhvODlTbi9jUktaS3pBSTJWOVJPRnlD?=
 =?utf-8?B?Q0QyUXNWeGx0Z3JyN2J0K3V6TXBZVW5jcnFhRnBvSXZoSnBnd2RTM1pxaG1n?=
 =?utf-8?B?K2JnSXBXRVVOMDBvVDhNMXdtNHhDbFlTVHg5cVNTaHIyZDV2aDZqeDdxb0I4?=
 =?utf-8?B?WGsrUWdqSTBkQVZOV1ZjYzgyQ3JZWjArVXZLeGJrbnRaTTNjQkoyZE8xVHNk?=
 =?utf-8?B?Qk5heHZNcXA2a2lWSmViUitVQ085VHdJUFRJbk5PZXhEbkIwRHdKcGl0ZEQv?=
 =?utf-8?Q?k5bEAUy3wEWxmQz3DJPpSP7lI2a+77cPez/fAgBAqGLkA?=
X-MS-Exchange-AntiSpam-MessageData-1: eP5PJhKIMHSdqA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f930e5-e648-452b-e2f1-08deba65a607
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:58:07.5957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e81zTy1/vGGHAbdx3mbOr0dFiOEIJW2EmTMeXG5hO4pjXzib1Ei3G36/L7w+OEkl5kPQC3IGFqgqb8suelVGxg==
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

Use checked access in `FwSecBiosImage::header` for getting the header
version since the value is firmware derived.

Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode extraction")
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index c62d918a3041..48a46684e279 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -1077,17 +1077,14 @@ fn build(self) -> Result<FwSecBiosImage> {
 impl FwSecBiosImage {
     /// Get the FwSec header ([`FalconUCodeDesc`]).
     pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
-        // Get the falcon ucode offset that was found in setup_falcon_data.
-        let falcon_ucode_offset = self.falcon_ucode_offset;
+        let data = self
+            .base
+            .data
+            .get(self.falcon_ucode_offset..)
+            .ok_or(EINVAL)?;
 
-        // Read the first 4 bytes to get the version.
-        let hdr_bytes: [u8; 4] = self.base.data[falcon_ucode_offset..falcon_ucode_offset + 4]
-            .try_into()
-            .map_err(|_| EINVAL)?;
-        let hdr = u32::from_le_bytes(hdr_bytes);
-        let ver = (hdr & 0xff00) >> 8;
-
-        let data = self.base.data.get(falcon_ucode_offset..).ok_or(EINVAL)?;
+        // Read the version byte from the header.
+        let ver = data.get(1).copied().ok_or(EINVAL)?;
         match ver {
             2 => {
                 let v2 = FalconUCodeDescV2::from_bytes_copy_prefix(data)

-- 
2.54.0

