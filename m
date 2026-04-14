Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9548AF9D0C9
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE0E10E4F6;
	Tue, 14 Apr 2026 11:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YokAqR1L";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013036.outbound.protection.outlook.com
 [40.93.196.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60FBE10E4F6
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AodgEtJZtiRGTjw3qmNpgoLgiR0VF+yaKROBHF1SQ6E70tFGlhQ1TCu7teBPg+4xiy0ydtn4ADXxr2sKc318ff2umhZQrDac5T0n7moALqOwok13p+5YHrkGQV9b7S1OyHgPKEKHmgkUXMAQ2vRwqTYD+gXwNG9VbdAmmNVar7XVbhnJkSffabHkewpf9BtmaIyVOIk4OpfUVDjC4DneFiE4GTLjAm/lhyRXj56AVHitLmRJEZkSCIaP3INfIpJAMQP9rlmhfWxqXDYcUufebsz8lY4JgsWluI7hOKJPpM+sTW6MhttQu0/Hi4Qy7wP+zmzvVeOB6F0PG29EIT6Abw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmnBV8B9jQCKjM1UQz1hof5IHNM9xMnmrpvWclye9cI=;
 b=TjFVFltO5T59KEgNh4GbrjAfK1XEEY2qMV+3S7xn8iT7iRAjCE1JzqIbQnpCl/vnVxJ8YeRcUPbnh+hGAAfbIUHgX4Gm6z4W3YvNGMmco2BBqpBGLGS4wJfO+GK83uFlM1lz0tMEUEEkZNHF0ufrQ39QQsSj+MfS9ffSyD/m38lsUvn5C2XYEVLWDleKJlV3CbOAuxLISiyoGDD/XUI47TrbsZjh2GZAth7PmFKVWZOGuDCI/c1J2gF9avJl7h8JAHJZlM+y6lVVRePVEXkYQQTtyugRbmpRvsvwo1lcriudyD+SKtDPBAsrgK3ZsZmJKstZenrlUscnrZS1Nuq3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmnBV8B9jQCKjM1UQz1hof5IHNM9xMnmrpvWclye9cI=;
 b=YokAqR1L8cHdvJFfCImxsUY67n0VrJkzYO3hjBz7ENLAzfhrsOy+9HXhshJDVf8i73vkAvH6VPC5oPBHTvWw15xOgq2s9xXSjFR60JFwk0DeAsQWOlSTnfmSkclBEqM8JLLuNliLKUFBDD/Jj2rlAz1CXcOlOL8v29TQW3u6UaLkreTioS7HpB5ABV0UO9cpqMntSUgD1AtZlk2/6Jkea4mM9dOuDJZKDqbC22LQJ+mzVpRggYqc8K/Tp0sNKi9jtwjOmX/ze1ZqAGIOCx6QeDAhpMHtY+G9f60FcrAVDNBdfXi7n2Z7jsz/5NA5lq8FyV5eMbiWDeiFT4fHN+Xo9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Tue, 14 Apr
 2026 11:54:21 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 11:54:21 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 14 Apr 2026 20:54:04 +0900
Subject: [PATCH v2 01/11] gpu: nova-core: vbios: fix various cases of
 reading past `BIOS_MAX_SCAN_LEN`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix-vbios-v2-1-705d30d16bba@nvidia.com>
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: DB3PR06CA0021.eurprd06.prod.outlook.com (2603:10a6:8:1::34)
 To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: a02c8731-5aa8-4ccc-0dd2-08de9a1c90c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: vMeGwN1KCU/8O+mb1/gNn5o6REp9ONlyB6J2ud7mKCurjNB4fCJ8/NXHZOISX+1/pbbz2PO9q6Tpr7h9QoB6xUTPT3uUB6arz93K+LwrfvolDwodXrxaZx5sPK9of9kxRI2FFkaDp0Qy8cBI6LiZH9kco8Y9qn25UrLwcZxg25jvNByZ6cuLKs7wjnnE6CNxGXlpIcE3LwMIYnMayaG/j/+iZ1u/n8VouVBKjupveRfF4j4wTBkcJjHF3S4HUzsFsQMcTLSKNIlcdSUxkxbGxpaiez0RvVTvsm2SuwUO2hGwWp+pbHXzL2pU5zuTUoW26Is2WdU5N5B7MhAcyQQyq/cEylrfpwuEUU+mSYMHYLh+jd78OmFbSFq1Emc9pWITzgF01UX9buepHrDdLfim4nilmZOYZpdqj2SC1UogUT9n0WREp7QnCerptppqDDHWax1Hz9BstnKl2Vroq2CwZDAcRAODowb5FzvplOolpPlo4rRYPa20S+I47dlT3Oweo0+5nJp4ISLNP/htm4zNLRe8dKRm0VBtopvf5h7o707LdXXHa9/TmMEsiIgRS1R+vWMUja31ZDnvnSVVzStq7RveATBFoix5HU2h/7aQte1JqItGBUqe8t0QQBWIrkmCuNBjYupYCW7tSWZs4JyBI0IDZ2LNv3S+RBR1BF07WeG1N7IjJktw3zDOGrlBFpdZxd/myaUCX7zfm32EazZ0WvNGNfwcjhvZj/QBgt53nVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkJJVnR2UVNKYVFva2dNRERXN3RPUXdvMTAzN0pWQ0NUOFF1ajBnSlplZzVF?=
 =?utf-8?B?TGZHRlovMWRmUmYySkxXL0p5Um1LWVVhRnRySWV5RVZmYi9scTFodGNVNEN5?=
 =?utf-8?B?SHdYOUN1blRYQWdGMEtncloweVQ5WUFZRFRoRTB5V1hVNVh1ZmRhOHlFMVJH?=
 =?utf-8?B?ZTZ4WHd3T2JHU1FmWVNJMDYvb2FQZ1MvWGk1dnZucHVTdDNYclljL3J1cDVK?=
 =?utf-8?B?SmxSa1poUkpRU2cxaG1SMkxoSEVxYWNPL1dSRDFBMHBnSUs3R09heElNcGE1?=
 =?utf-8?B?ZERPekNVMkRyWGYwVHNGTTNwL2Z0UW4wL21uTkM3cGVUQlUwRVFlaytYVnJV?=
 =?utf-8?B?Q1MrYW5aRUtJS2JkT25HcGkvQUhOWkhjSE03UDBkQVYyRTd1VEdsMmw2YWg5?=
 =?utf-8?B?RWJtNFRoOXlMZm51emtWR3FTWm5ZVUwrRHpJTDVUWkM5NDkzZ3pkeFRnYUNR?=
 =?utf-8?B?U0c4V09XS25IOEY2OUg2TDdZazVDbEo3SGs2cExUNFYvSDM2OGxFYVZuQW9W?=
 =?utf-8?B?S0EwNG15NmJ4cmFVbVdWeUNwZ0dUV0NkcVFOUTRkVzhUNHhxaEdNSzhYS0FV?=
 =?utf-8?B?dXQvWmFueGJDK2pzUURNcjMvYi9DZlR6aXZUS0crZFFuR2RqZ3Y0MVZFZ3Rq?=
 =?utf-8?B?OFl6cjg1dFArMFpPUWhTSHRUS3pXSzN5ZGQ0U2wrci9TdDZwTU1mS2JQU2hw?=
 =?utf-8?B?Q0o2eGlDdStrUzliLzVrR0krN1VPQ1hmVjJWNGRLS0dBdzBHNkhBN2dUclhh?=
 =?utf-8?B?Y0tReFA1ME54cVV5NGQzWUFjOUFKMVp0ZUVhdUtTL1YyZnZPYjV5ejVHdS9B?=
 =?utf-8?B?ZzJNMmh5Z3lQOW5oaWxSMElPemU2b01zR1o4cjRaRExCM25qK2hRQUg4T2lJ?=
 =?utf-8?B?c1R1aGhLbzFSOExkOXlMMG5PVnB2UURHNXIwRHJLRnlSV01Kay9lOEZOZmNy?=
 =?utf-8?B?V0trd3BTSTBjT1dsME14RnFwaHBtUTZlcXRySmZQeUprWEt3Um0wRnRmZ2tp?=
 =?utf-8?B?aUJGYkNwWHZBcGxCVzk4QzJFSE9KeEhUNW1GYUViZGFDekNteWdpNmlvdm1u?=
 =?utf-8?B?VkNNMnVEWDZhTzVUSkdpNisraGFCaVJVQmV2SWRxUThZbGVqMm8yYjY5N3RV?=
 =?utf-8?B?RGdJZlM2WjQ3U1NoSTV5cDlNVTVmaDRBV3lTZThkSkplQXRXZUk2VHNCYWdL?=
 =?utf-8?B?VS9qaGdhYmkyTmduRVI4NzcrOTk2bmo1R0NoUFU0dkt4ZmlxeVBzY1hqRzBS?=
 =?utf-8?B?ZFgwQkM3U0RMNTl4ZDJPaGtuenlOekxZTElyQzlMNDRDd1B6UVJIMmowRWJZ?=
 =?utf-8?B?Zzg2ckU3cWFITW54VXJGMFdDckozQVAzYmhlNExaVDBnWkdqdHBrd0gxaFFZ?=
 =?utf-8?B?VkNQYlJLUnJnTW02MCsrZVRDcHU0aVdRa2twYUxYMUtFYjFyeXhqS05QYzc5?=
 =?utf-8?B?SDhpREpETHowak1wOHJLV3pxdlpVVkwrTVIwUTJqUFdQWHV6U3BYOUxMM3Yy?=
 =?utf-8?B?T09wZ0RRQnh2Mm40M2ZqeWdyZVMydnVCOURpeFV4OGNBYnpmb1F0K2JZUE5P?=
 =?utf-8?B?N1VRMjcrTmtQSFI0TTgyOTRodXF4UE1EMk54TzBYWGtTQ3ZvRitQSU9uWlpw?=
 =?utf-8?B?RWV6ZXpDa2RaZ1ExQkFrWnVPNzQ2RmsrTEYrTml2ZVZtQ1l1NGxpWFlza1JY?=
 =?utf-8?B?eldhQ2c2Vk5Wb2VzUkxQa1V4WG1IRHJxZ2t1UUE2MGpab3JrMTVndWt1RUNR?=
 =?utf-8?B?a1NzVGQwUm9nT2FzeVUxM2dHbVNBODVNSis3ZjNGemdiL044ODJCZTN5dXBu?=
 =?utf-8?B?eGpKMWIrdnZaamVhU2g1WlFjaStBYStTclBSc201VmRKT25rOHA0aFlxUG9W?=
 =?utf-8?B?eXM0TjBkdGdZTmNieDlZNHJhR1pxY0dUc3RpTDlZQlpGT3ZzVkx3MHM1Yngv?=
 =?utf-8?B?a2xwWmxCR0x4YTBTQ0liMTFwY2k4UktGeHJ5bFFCVklJYXl3TDd6eG9GYnoy?=
 =?utf-8?B?RzJSMzVsK3JKekpZdUp5dS9LWnNSOTRGVEd3VWRsQkJURHg4QzZ6TmZDcjNz?=
 =?utf-8?B?bmh6VG5xcmVxcXo4bDJsR3pEUEVhTDhqNzhORkNGWm9Lc0xIVDRCcXI1UTVs?=
 =?utf-8?B?NTZISVJWTk5GanNZYjRGbjFHbmRlanpJZ0tzRlZQMWxyd1FsRVNPaXMrWjN3?=
 =?utf-8?B?UFY2YVJWSnNIWFFOZ0FScGs3Z0EwWjZjNDlMYi81MWpFY3g2dFBrNTQ0bWJY?=
 =?utf-8?B?VmRiNUh3dkFTNE5hZFFMMW96WGlwQ3BkM3BuRGtZczRoY3dvVUVab204REJi?=
 =?utf-8?B?RWl6SDRURGNaUDhPZVphakptOE5QZS94QnhXVUtkZ1hVMElLRmZFUTlmZ2Qr?=
 =?utf-8?Q?IrO4eTAD7dCCaD8ygu1J3jj7hL1f1Wd1RIggvx0QCjPsG?=
X-MS-Exchange-AntiSpam-MessageData-1: 8RB/izqWznmbQA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02c8731-5aa8-4ccc-0dd2-08de9a1c90c6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:54:21.2842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhGYTUJ7/eomMpdf3xJ/fNoGQ+Bd2sLAy9mIBj8mjdBdTm7G71SxohkSxHyFQnGkEUnrWOGksbHyN9e/8/B4cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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

Fix various cases that allow reading past `BIOS_MAX_SCAN_LEN` when
scanning the VBIOS.

Fix bug where `read_more_at_offset` would unnecessarily read more data.
This happens when the window to read has some part cached and some part
not. It would read `len` bytes instead of just the uncached portion,
which could read past `BIOS_MAX_SCAN_LEN`.

Also add more checked arithmetic to catch potential overflows.
`read_bios_image_at_offset` is called with a length from the VBIOS
header, so we should be more defensive here.

Fixes: 6fda04e7f0cd ("gpu: nova-core: vbios: Add base support for VBIOS construction and iteration")
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index ebda28e596c5..6de7e58e0da0 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -132,17 +132,14 @@ fn read_more(&mut self, len: usize) -> Result {
 
     /// Read bytes at a specific offset, filling any gap.
     fn read_more_at_offset(&mut self, offset: usize, len: usize) -> Result {
-        if offset > BIOS_MAX_SCAN_LEN {
+        let end = offset.checked_add(len).ok_or(EINVAL)?;
+
+        if end > BIOS_MAX_SCAN_LEN {
             dev_err!(self.dev, "Error: exceeded BIOS scan limit.\n");
             return Err(EINVAL);
         }
 
-        // If `offset` is beyond current data size, fill the gap first.
-        let current_len = self.data.len();
-        let gap_bytes = offset.saturating_sub(current_len);
-
-        // Now read the requested bytes at the offset.
-        self.read_more(gap_bytes + len)
+        self.read_more(end.saturating_sub(self.data.len()))
     }
 
     /// Read a BIOS image at a specific offset and create a [`BiosImage`] from it.
@@ -155,8 +152,9 @@ fn read_bios_image_at_offset(
         len: usize,
         context: &str,
     ) -> Result<BiosImage> {
+        let end = offset.checked_add(len).ok_or(EINVAL)?;
         let data_len = self.data.len();
-        if offset + len > data_len {
+        if end > data_len {
             self.read_more_at_offset(offset, len).inspect_err(|e| {
                 dev_err!(
                     self.dev,
@@ -167,7 +165,7 @@ fn read_bios_image_at_offset(
             })?;
         }
 
-        BiosImage::new(self.dev, &self.data[offset..offset + len]).inspect_err(|err| {
+        BiosImage::new(self.dev, &self.data[offset..end]).inspect_err(|err| {
             dev_err!(
                 self.dev,
                 "Failed to {} at offset {:#x}: {:?}\n",
@@ -189,7 +187,7 @@ fn next(&mut self) -> Option<Self::Item> {
             return None;
         }
 
-        if self.current_offset > BIOS_MAX_SCAN_LEN {
+        if self.current_offset >= BIOS_MAX_SCAN_LEN {
             dev_err!(self.dev, "Error: exceeded BIOS scan limit, stopping scan\n");
             return None;
         }

-- 
2.53.0

