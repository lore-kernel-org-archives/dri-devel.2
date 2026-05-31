Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009C2CD5BD1
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 12:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41919112B25;
	Sun, 31 May 2026 12:37:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="f9B9fBir";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E154C112B25
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 12:37:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOyvLB5xOWx++VHFHvaC4u8OLtQ16DyRMi2oVmY5lIU5Gk2qKcdrwiGIems0LvD45T08vOzrXBgcrz2eSOHwxVi1smqLtIWYlVgX+X0qaONoCTMM41DeKNVtpQvl9rKbXpulUJHa0MXCE3KvdROsiGoNQ9w/OhcjoheUrN47ZvVX+jwGdoC3vBGcbmi1GgNS7vKIvW+ml1H9cnbpRE+Q3kXG6esgpyq2+fLkrYVi7SMhu/ZmViiqfN1A0mDrP5CG1kqcMJ9ctYUK6Qs/j+kEhGE0FJBo2prBJJyJ7WXTy9YXckfXNdl5A5qAqowHIBBS3/vkYO+W2dWT1ANDwb0LAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUEc3ehyIThdaKDIjEOr4e1NebAeWZVZt+qAloqR64M=;
 b=E9ds+W6RWYS1FGoR6ayshiMsAHrO3yjdY6MoR2rKs7Kl1oMBR+Rhgq019kvnzq2fRNRu4bZuuSv01B3ahi8TiK967CNTtIU8gV6q4QZCQwhM6GABODT2CORf0oKywhWdUiFhNIFio72b+QgdttPI+JH6QFcJZhccEvf2sqVZr8wpKwm9HyO2H1Vqywxqk5FOR9e11gCKSDbbmh8t0Uc3dizN/JArQhyZV/4ZNn7/VAuO+KoCeT1oCfpqSJ4Yt/G0vX2FRgH+tTDzmgZ9MTQ91DrXneyME5xwp7R3LdvL+5A3qBphcTAA9MLVzhKLQwmm/7G79vxzDzd1jWEtyKhwMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUEc3ehyIThdaKDIjEOr4e1NebAeWZVZt+qAloqR64M=;
 b=f9B9fBir2XMw+pEACJ57L+VEX4LxsJ9XKUZHXV4mPV7Rd3vZFSTFLviUuI5vrqwlikTOtpIIdUEPl8SIputlTSQJgR2VoU6fDM3pkT4T69moQqg/kJwTJvWxfR3+d6JbopMqfwJvxfbcJ2tixOebUZqEXXkzIzVRwCRjEfPrbYLssukeqiG+5MCv8c8ci4EySz0JAGibaEA+A0g1/VrJA5TOSELsh5NX0U+GDJkuYLDIPvJN4z7143RHiZAgy/QXWAU1ezxWiuekAJ+4+LxOhy8Ny8lx7stytqBxfYlTGN/sfzD68dBVhq3o+h9OcAtV86onfmQCAzZO/FWUKn6jtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Sun, 31 May
 2026 12:37:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.011; Sun, 31 May 2026
 12:37:31 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 31 May 2026 21:37:27 +0900
Subject: [PATCH] gpu: nova-core: gsp: tu102: keep unloading if FWSEC-SB fails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-nova-unload-fix-v1-1-c8dcdc769b53@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrE1SFOEqYlE1GJFWWkQi7q5Yf
 i95/wWeHJOHOrrA0cGerQlI4gj0pMxIyH0wpCItRJ4laOyhcDeLVT0OfGKlC5JlpfKslBBeq6M
 wf8Wm/e33bia9vRm47wfZgxKIcwAAAA==
X-Change-ID: 20260531-nova-unload-fix-9c6e479a5374
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Eliot Courtney <ecourtney@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: 1367c74f-cd7f-45eb-f901-08debf1161de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: W7ROirzbZH4BdQH8mGJDEnOC/7KZxknn5MZD5cKA2tYqTU0t1uLLHrdulsUU0kZF7scfdRz7Bmjgkyl4vILyak/6iZi8PEqL8TSGz6azrLPGLg67RoNVzNcYaFGvs09UTQYDlSj4Q7rrK8+D4+27L82NZvz+FcDf+rcoJH2E1mqfFyPGbIPymQSTrLvKfL6zXp9YeYzMAR/Y3wvUG9HjULtA2NB4Q6+7/GVyFG6X4LPYnCpRJjJRYQaHFtEHLLK8HWwkvR11k0Ri4AA6bliRDwxwFnoZftKWeNBlXTBUpN2oeI2XT0bsx1lGl+asXIxhabZSQnpCoMUZ9ohuc7tat611Q6+dD5c4NDbqzvRq1C+SseSHlV+KKQrQ8ed3fM5sbLP0A5ZlCX0UPHvi0A5jErJTKxVhICuskwmY+JPbvE6nZG0HRKx8/2W4+K0KKtOr+ooV9RGiTey0cRTQNbekqe35hQY/GXvVD4yvlLhoXeF3lsmRR55EV/a6x7hVksIC9pvmpK1uoblG2unBRapG7ABRWeZ3VO5a4xBe0Tpu4MCDjFXUeoPT9K4IjoGEk4X+Ws88+218Mggt4Mqejkm60WERwOZ0gWYGOqJfC+mOrW85g0rqK9HG+Kb47ZlXNR9V8L5hUNXuxjStnE3zpF1KasY37+N/bSL3v8wJNXGQdGLb/jIadzIkCsDRQfq9Bgxo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDQvaTNJMWVIaUZ3K0w0ajBXcjdsYjBSRXhUTTAyYzRvdTlHWkc5Yk9WMjJ6?=
 =?utf-8?B?eCtSRDFVam9CKzN0UTYzMkFUdXBpSjdXMkI2bkIrQTZFWldrbFBPT0JGZmoy?=
 =?utf-8?B?QWkyV2NkUURDczlWajkvMDZUeXM0ajlNVDQyVCsrUzRVazFmUjcrMzRib0gv?=
 =?utf-8?B?aGZtdUsvMEhTU2d3MStUWlIrUkxieWlKV3BvUitya3NEZk5SOVFSRWI2NzdS?=
 =?utf-8?B?RFkvOXZ5ZG5xYktTMG80L2oyK2NGNVIrdHpyVVFMNDJEUFhRSU9EMGRuVjg0?=
 =?utf-8?B?VWdGTysybTRYbUQyQW4rNHh1QzAzTnJqbEZNamdyaFVyMjJmNGd5QmVrY1Ni?=
 =?utf-8?B?T2RWaGlENXg4cjQwWHg5cXRaUDRlbjdwaFp4ZG1vUmozWHdzalFRNFYrSy83?=
 =?utf-8?B?eWtwVjJxUTNjZFZkUFQrbXZJYXUzVkRJSW15MXlvWFViNHNLeHlJVkRuVnB2?=
 =?utf-8?B?aVdmZDJoTHUwTWxFM2E4RUk2VXBncC9sci9ySUVuM1FVbm1kUnV4UFBtR3lo?=
 =?utf-8?B?TnhTVXhJalJqNUtzUkhBdDh4c2hJS2toRVVkRHdPNjhWR01SSUkrTjBWRXAw?=
 =?utf-8?B?T3pDNEJxalA0dVpONjAvb1JoUkNRUGljbnB4aFovL05GMG5Wa3VnemFQeHZ1?=
 =?utf-8?B?NGhnYnRiRlJ4MXl2MjlrdGpEMENvR2JsZFYvUE5hejIydFppSWF4RFZkS3lQ?=
 =?utf-8?B?aE9Ib2NqTzVwQUJmMVBERjYzTEF5Mm1pN1BaR1RkTVhNeHpWbGZwaEFaeEdx?=
 =?utf-8?B?MVZldXBSNUd1eVR4YTRTeVdXTFdudzQ3N2xETXRaQVBvZXdTSmhUcUpLekY0?=
 =?utf-8?B?N1oydktRSkNlL0lQNW93a3BscUxZZWlBZHJ5OS85WjVJbFZtYjBwc1F5VkRR?=
 =?utf-8?B?NWlFb0JCQTVEeGt5Tkwyci9MMHYzVk84T05DZCtFVGFtZUNLai9KSmMzQjZj?=
 =?utf-8?B?Q0VvOG8rSVd6R2dxd1RIMjNKUW8zam5xaE9TbXhISnhjWXR1OG5ZU1NmYmhw?=
 =?utf-8?B?YWdzWlVBWDhUVUpLMnA4dzF0dWZnOEloL1VTV0IrNWVrdGZxRFN4TnMyYlBw?=
 =?utf-8?B?NWJZQ3pUdUdtb3dWSkltSmVjY2c4M1R6T0NacFZOZjNPSEFRQTFxNlZCekkv?=
 =?utf-8?B?c3JDOXMzSWJESGZ2TThOWHROenhVM0MrcUJpZCtTMmJqOUhZMlZGTVZ4R2R2?=
 =?utf-8?B?ZUVKTEpuVkFJZ1d2c3lnWE9WK2k2aW92S3RYSENLeHozdmhUVWg2dmVVSFZY?=
 =?utf-8?B?TkhsbGVFcFZ5Y3pGWmpjQzV4NndLOCtENFMyam9DT3lXSjlmNy9TUnpCRXRR?=
 =?utf-8?B?d3k4T2ZHMStQR2p1ZHFBRWhoci9OQnNBNExzV2E0S3ZxbHY5S0NvU29mNXVV?=
 =?utf-8?B?d2VCczhFVUptaS9wbVZEWTZjOUxTM3N4dlJoNzR5N0hMNXQ0czl4aFdZamYy?=
 =?utf-8?B?NzhzamIvRzRvL0lqK0ExNm1kQmlRN1VjSnhuc1NPYTNOZGwrYXU0eC9pVm9V?=
 =?utf-8?B?SnIvaWpFOU15ZGJoZCtLNFVCSU1sd2FpZHRlcjJDWnFSYVJDS2F0ZUswTjdX?=
 =?utf-8?B?MDJPRVo3bmpjdkRXeFVMbGdReGtxbUJsUUEzdmhtcHd3VGp5SEU4eElVM3ox?=
 =?utf-8?B?UkVoZkZSWlRlalQ3QnpoVUdTRmF2K2dITkd6M3JXVnNiOE5NajRTY2JtUTZP?=
 =?utf-8?B?cFE4VEl0dG9lN0NUQTFMZ3U0NWZ5dEg4RTJpRFBzd2dQTkZPN1FjTUxHeGdY?=
 =?utf-8?B?WE1UUE1ra2Z6cTJHdkV6YktBREtpVCsvQ1pQOVp6R3IxZE1MVUk4RFY2cmtW?=
 =?utf-8?B?WjVSeHI2ZHVOK3FZWlhWNG5BNmlzVEtSNXorQndiZWo3N2FDb0t4emdadDdi?=
 =?utf-8?B?VmVkcmJGc2FoUnJ0a2JLSnd2bTVka055cDRhRmV2Y0ZCUTZXMlNzdXJ0L2Jy?=
 =?utf-8?B?VzI4Z01peWNOYmY5NkIvOXp1QWYrSkxuTXZwNW5NL0hsUld6SjVCMmtkSGJn?=
 =?utf-8?B?cmpEeWZKV1MxeUpmVVJxd0I1TW84ZWtTblYwempNa2Y1Zk1mQWhHdUhpVS9n?=
 =?utf-8?B?dmVNbzJnVk5NWTU3TThXTVByL2JzV2lGRTBNMTFWM3VLb0VSbVhpeVkySlZi?=
 =?utf-8?B?dU5WcyszdE5ZMGJqVUY4cWNYUXN2U1dkTkJTM0pad1ZLVHErU1VKMmNLQ3R1?=
 =?utf-8?B?MGg0aDBmUUlyTFlSTXRlMXZsWnV1d0pKdFRLa3dsUk5HcndmZjF2dG8zc3Fq?=
 =?utf-8?B?L04zSmlZVTh0TVVyRVVxK2JpQ2hjbDg1aHRhaytXaHlXNHpvdG0yNTBFOTdw?=
 =?utf-8?B?eUtidndoWDVhVGdMKzBkendQZ1plNDBVNCthbHJ2dWNMUzZRKzNGNFg0TFpj?=
 =?utf-8?Q?GGEXQdAcHN2TBQNuAgWZ0Bz7Sh/b2tscxR5qu/hTf2z8P?=
X-MS-Exchange-AntiSpam-MessageData-1: XzWNOZ1ftAJVOg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1367c74f-cd7f-45eb-f901-08debf1161de
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 12:37:31.3532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGnVsx7zgqTlQWsouTGl6FXWC7YBDZ9MFJqC40COGS+Sp2XAUN23eriZ2QUaXYubMdxzdvjEN20ARmJ0yBaU4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098
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

On Turing and Ampere, resetting the GSP involves running two firmware
images: FWSEC-SB and Booter Unloader. They are independent from one
another, and we should do whatever is possible to restore the GSP's
unloaded state even if a failure occurs along the way.

Thus, keep going and run Booter Unloader even if the execution of
FWSEC-SB failed.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260529-nova-unload-v7-0-678f39209e00%40nvidia.com?part=3
Fixes: adb99ce3cc78 ("gpu: nova-core: run Booter Unloader and FWSEC-SB upon unbinding")
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
This was caught by Sashiko; I unfortunately noticed it after pushing the
series, but having it as a follow-up is beneficial regardless as it
allows more time for review.
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index a033bc892066..b10215190257 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -134,11 +134,19 @@ fn run(
         sec2_falcon: &Falcon<Sec2>,
     ) -> Result {
         // Run FWSEC-SB to reset the GSP falcon to its pre-libos state.
-        self.fwsec_sb.run(dev, bar, gsp_falcon)?;
+        // Log errors but keep going if it fails.
+        let fwsec_sb_res = self
+            .fwsec_sb
+            .run(dev, bar, gsp_falcon)
+            .inspect_err(|e| dev_err!(dev, "FWSEC-SB failed to run: {:?}\n", e));
 
         // Remove WPR2 region if set.
         let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
-        if wpr2_hi.is_wpr2_set() {
+        let booter_unloader_res = (|| {
+            if !wpr2_hi.is_wpr2_set() {
+                return Ok(());
+            }
+
             sec2_falcon.reset(bar)?;
             sec2_falcon.load(dev, bar, &self.booter_unloader)?;
 
@@ -160,9 +168,11 @@ fn run(
                 );
                 return Err(EBUSY);
             }
-        }
 
-        Ok(())
+            Ok(())
+        })();
+
+        fwsec_sb_res.and(booter_unloader_res)
     }
 }
 

---
base-commit: 75d59327367dc6e2141cf4e11cdf57c55851b5c2
change-id: 20260531-nova-unload-fix-9c6e479a5374

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

