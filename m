Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71524CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 13:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C543C10F32C;
	Thu, 21 May 2026 13:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AJPtcVuG";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013018.outbound.protection.outlook.com
 [40.93.196.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE2A10F325
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 13:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBEuxg1GaHlDexxSRp+B102yau5V59mtRZCPj4p/paYeskffE7p9IMx/e4gntB1GEVRNUHcPwPmci8XztsPwDPU11YUva/lvBerPRjR6FS+/1anNZEcUSvMJQY5sFQN9clBOgFoT+jNU6rzSS1HC8wt++ze+fbqufpx1vkiUCBg8pOtkFgzrwcFKSkcyHY7Apwbs2VSDpNkaAEf+dHyntEHKLGbGJ1LzRILBFKKNOZLxyy/LR509diSEnIP6tqYjRd/6+jlbTvSu4A8U/ysG02hJLSm7TEhmhD7+HfuLabF7X6f+MDLdxZlptkIUZCOfcK9Me5thCItcEWImmyaT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRUiX57sdNDAomQx6WDF25cxC/hhoFwq3uUy4AhN024=;
 b=gWvArESVFZpiffwTxFmDQuWkgTOEumXbS8Ql7THXIsWaNUI05Vkc7aRrJhKKz+autfdb4a7QyCQJbjVVykjdedKBhNdeU2CLZZtKOiUcTxW4JnIYWOhsBMl3sELmaJ7Rh4ZaxYp2CNzOxDoxObTuvoVJjYU1YxdXYYV/LOGD5NEiyralSQFk2GSYakvcO7+MC2cSRlXiOuD4va6+gotyjW0nShRryR58blighGH+YcNt4rJh1RaBlRi+qP3HpMrwPTa9y2e+Bc1bJdG5XzIgokNxPbFDTkzqGTf01huONIhUcojaR+CdMg+8RryQO5AJAF2WyMCZapCWNeNAPjCk4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRUiX57sdNDAomQx6WDF25cxC/hhoFwq3uUy4AhN024=;
 b=AJPtcVuGmPToeAuJZ81woa9UsmIr8VKg2th8H2k0q/Bi1siMd9ZAEwe5rsJbdc4K4bzR9cUDqRL0jZsgM+dAXjXaqhjavQ9aZ0M5g1YIQCdrskp6wTpg34E4ZHo9VPBGS4yGjmxAAjEBm789fP508qySFP29Zpp7yhiuPo/4atQPenEEuvLJmt1mNcL16UD/XYU30J+OX5Q7vYPGeGr03qCgmiABMxOjqufrjE9iK092kOjSkKR6XoZParkyiGQx57djgtbW+X6YdtYxs/W49ZdzYNUO0E48QuHe0pv4bKK6Vi39pqZYaM6yxUmuYt8ftuUehaG5oAidpfsEOkFUFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 13:50:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 13:50:59 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v6 0/7] gpu: nova-core: run unload sequence upon unbinding
Date: Thu, 21 May 2026 22:50:47 +0900
Message-Id: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NwUrEMBDG8VdZcjaSmWSyrSffQzwkmakb0EZaD
 crSdze7IG6ox2/g95+zWmXJsqqHw1ktUvOay9yGvzuodArzi+jMbSs0SIDg9Vxq0J/zawmsncE
 x2nj0IxnVxPsiU/661p6e2z7l9aMs39d4hcv1/04FbbQPxAPaKDDy41wz53Cfypu6hCr+Ym8cQ
 o+xYZyE3OhtmIa4w/YWY49tw8CYBohsk+w/u1t87LFrWMBRSsxBvN9h+sME1GNqODn2SCYweNP
 hbdt+AMCJpNqbAQAA
X-Change-ID: 20251216-nova-unload-4029b3b76950
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0067.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 12687f71-3b8e-47f7-6f42-08deb73ffceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|18002099003|56012099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: D5/XcQHmxwA4QkqZhNDCD6ly/vqfJIFQSxTpHTqf2xZy+gxgEUjGnXGMyduashlAQySlr480YUt6pkY+8shTpNUQgEkC9GbvfMtrcwXU1aFrdLaWBoyNsA7jyWwOJCGrW4O5cypmZbKRBKQkDWPspnnZYuXhOljd6aDVfax7hWeiSAS7A3WF1aVy+EgoP95w0xNrk5ltNyDutxqJKd5JMqAQf1kKHK0UXJmkzcknpicJywi3Q9YhSGbluXDAsKJzDzJ6B5S2x3eSROs1O/GwZ58OsuZNQaLOBY1oliPNHA/KAiqNbRaf15qsVDl6aYaqJCivBsMC48Y+9vp1HneG91YoH+Abwc9gm8YFwDUqNmClUC7WZD/2Xv5y3jePg6t2pTmxD7p3PF3mmtyt1dpaqbcswYcpI0ci9Ri82xl1wJ6HogLggy1Y1hiUqxOGboHxhMQ7oggUv49J2qc1gB50+9yYOKevFdMk9f8IU+aPmedxZsxBDigEcYkIgeqBByuRbtUL3WZlNakCUOkQcmNNc+0fhca+5u7FM1oqh7n/3ZcpB4Rqa+W3EwUNWNgxv+mOCgfQb0IYRQEAHu3q7j4Wue6HHAnuIpUWD1i+aU0xwwI+39pzcOZxaDoXpApI/NreMcKHDvCt60mudggAlkCLsDNb149mJpC8m4K8FD7D1LuYTUMrYQEWFFH3rvutjY4T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(56012099003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NS9vSWxwU0VTRkxhZXVmNGRsMk4rR3JQUUYxSnlZWkp0V2ViZVZNckJ2ZE9H?=
 =?utf-8?B?ZVlRUFdNbVhHWjYrMGJVQVI1ZXp0MDJ5eEpOMnUzMHZQOGh2eDRoY01nQmxN?=
 =?utf-8?B?WGJ1cjl2QU81S085aUR6QmhxYlowc3ptUmN5M2pKQndLTGVXVmNXb0ExcnQz?=
 =?utf-8?B?aDFFLzF0MGxKTVVFaSsrZkZZSGZJMnMwMGxCV2t5M1Uzc1ROcldZajh6cFZ4?=
 =?utf-8?B?a3VhY1JMM1RRcElTOUc1dVNMQ0FYUm1EbVZhVDdOSnd3UEphcXkyMWw2dkVx?=
 =?utf-8?B?UndXRDhpc3NUWUlUOU1aNkkrbVFNQmxhZVBrU2p3dXlNczFMc1ZJSUhENmYw?=
 =?utf-8?B?bzJpTG54YlIzbzA0cXVGaUtDWndiZTlTN3FyR2RXSkJpMHZvS3BxTHBUYXJD?=
 =?utf-8?B?cC83ellkcEo1em43c1M5ekY4bEwxNDNpWUdGSlQzc3A5WldDV2g1OEsxeTAr?=
 =?utf-8?B?cnVtczlWR0dvSFVMQVdEZlduT1FXZkhNMVVVZ3drREtIYkpwM2xJOXpDeHBm?=
 =?utf-8?B?UmJsVlNNZmx6VGF2YTNKQWVEUDJLdEsxaFVVUk5tL2xEQ2tweDYyOFhwdUp3?=
 =?utf-8?B?ZzdNUk9uT2xFd3JKemhxR25GYW1BNldvZHdPZ0pNeVRVOXNOTmtDajliQzdR?=
 =?utf-8?B?cE5nbmhtTVBPcnVQUkRnQkxPMUlSY25MdzQxQU42ak0wallRMEV3YW9RdFpl?=
 =?utf-8?B?SEM3Vy9YZ2xScjBBY3FQMW9MN2YwMjZ5cHpWOHc3K1VqS1FkYWFVR1dLRUUr?=
 =?utf-8?B?YXZVTmhtMTBzbVBpSlJxRVZKTGwrWlhCSWJHaTVCc29WYkFBalZlQ1Y2WnlI?=
 =?utf-8?B?Tlp0NXBiS01sN04xNnA4eUFEc09ud0xKUDVIS1h6UHd5VDBSdHZKNUI0OU5W?=
 =?utf-8?B?a1VpbGJUU1FmUTZ5WnNPa0lWcWlPejVGMVRKcFh1Wjk3dUpHcnMrTDltdXZS?=
 =?utf-8?B?T2d1L3YrdzFHcWFIQ0dEMUlmbVYxNE5wTkgxR0lyaU5icG9XVHI0cGR3MW9I?=
 =?utf-8?B?aG8vYUE1YndtMUE4M2JuZnU5WXhXb1hjTXRSWTlGNi9BVVJXVi9PZmIwUUVu?=
 =?utf-8?B?N3NCUnM3MlVyd2F0c1F3a29mOGVNUVc0WGtqUDV6TDVDSW80U0JSVFVmcFZJ?=
 =?utf-8?B?VnlyWnFNZmo4SFk0eXl4WEJ4WlVIZDVuMGowaDcxQndlUUhpQkNmU3lndVNj?=
 =?utf-8?B?K0Fsc3Y5TDcvV0YyRlpqMnN4NVhPUk1rdU5sNFFsNlFWRyt2N3hGZDJ2MVhm?=
 =?utf-8?B?TkVQRnllM1dRLzY5TzR3YXhhVlhwRTdLZmN6eXF1dS9yWTNUdEk3eDdFV1o2?=
 =?utf-8?B?Tm1FbVRtUjIzZnpUOUZUOTdNZmp0bHVra000MXBxTnMyZGJlQTUwcU51L1Bw?=
 =?utf-8?B?ZVJpTmFlNU16SlFDZ21QWHB5dlkrVW9meXdWNUc4S2YwK1VuVDB2dHdiS1BD?=
 =?utf-8?B?R204NFpKdlo4blp6ajE3L0IxOGFySjROdGFFQUFUYjNqRGQwOVlTdVVMdUVJ?=
 =?utf-8?B?enBBcFJNd3l3WlF4VFBYK0Fyc3hRM0EvZjdsVFBDZUVmWUE2eS8yNHRXc3li?=
 =?utf-8?B?TFBDMWRSSWpOMnk3WTRobkN1RG9Ec0JhcFUvVTFTNktYTTRiazVDbStNSjFY?=
 =?utf-8?B?emY5U0o2U3RTenBqUCt2Y09pdGRuSWMvTTV2SWE4VnNzM0o1S290c25xYVhm?=
 =?utf-8?B?VGEyVHlvc2hNVk5RMHo0K0NNTUF0emhUUURUVHJ4RzA3STFSNGJtbDVEb0JV?=
 =?utf-8?B?cGZQdElIb1ZjNzlqcUNHZkFXZ01EdjdaMUQyekluVnlZVE9iZmU4M3ZqQ1cv?=
 =?utf-8?B?MHF2SGpGUm96N0ovUmkraUFPWWhzeHZGUmlidG1lTHNrUyszK01LMjhMZFNj?=
 =?utf-8?B?dnVua0poWEY4NnQ0YkpUUjhjbG1xNlRPV2lORkY3RGsxbGc2Ny9tVmxRNWNo?=
 =?utf-8?B?MnV1Z3FwN0xRS2phTXl2dVVBR1hVMHJEelNUU0pzaEo2elpLdGlWY2wxWEhi?=
 =?utf-8?B?WW5lYy9QeXdCMFFENmpJSzZBUUZXU0tMckZkSEN3Qmk5ZXd5alpzSENHVDUy?=
 =?utf-8?B?QUs3OHJ6VmtzcktvM1g1YTVXNWZsdU82RFBONVhveVNEWHpjYy9IRnZzSG5C?=
 =?utf-8?B?RDhQM0djUzNSZ29OZ1QxYVNHKzVRRGFIQzJzakxtKzZ1OGRwbXFYZ0RYa3FW?=
 =?utf-8?B?dWdoa0k2QkVSaStvb0pXOHFIYkY2a1NiYS90d1QzRWFTRWpvcUpiV2ZuaExs?=
 =?utf-8?B?SUV4K1BzL2xBNmdXRTEyV3ZGSWdiSzBCREFFSk5UZC9DYTU4UW00Nk4zdlNF?=
 =?utf-8?B?VnNadVk4aVNWRXJacExZQnQ1T2Z0ZDRaVisrQ1NXRzErMlI4K2NhVUJiUFNR?=
 =?utf-8?Q?7y9bnOb7DaIHnhM2TYYPOSvkd25N/9ZPSYDrqvqX1WQVm?=
X-MS-Exchange-AntiSpam-MessageData-1: SiRDARpMPWLElQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12687f71-3b8e-47f7-6f42-08deb73ffceb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:50:58.9408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfa+VYusfdDzm6UHg8We2lxiwzlp/wFVA5DrX+RKsRM1Z3e70kOwwVTFWQTuTdbZ0VRiry/Sa/DSPrpO7E63nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
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

Currently the GSP is left running and the WPR2 memory region untouched
when the driver is unbound. This is obviously not ideal for at least two
reasons:

- Probing requires setting up the WPR2 region, which cannot be done if
  there is already one in place. Hence the current requirement to reset
  the GPU (using e.g. `echo 1 >/sys/bus/pci/devices/.../reset`) before
  the driver can be probed again after removal.
- The running GSP may still attempt to access shared memory regions
  which the kernel might recycle.

On top of that, there is a nasty bug in the Blackwell VBIOS that
sometimes borks the GPU upon PCI reset, requiring a reboot. So relying
on the PCI reset to unload/reload Nova is really not practical here.

This series does what is needed to leave the GPU in a clean state after
unbind, for all currently supported GPUs. Blackwell support is basic and
will be added alongside the Blackwell series if this can be merged
first.

This revision rebases on top of the Device HRT series [1] and moves the
unload bundle from `Gsp` into `NovaCore`. This makes GSP unload
initiation only possible at the driver module level, which is the only
place that can consume the unload bundle.

A branch with the series and its required dependencies is available at
[2].

[1] https://lore.kernel.org/20260506215113.851360-1-dakr@kernel.org
[2] https://github.com/Gnurou/linux/tree/b4/nova-unload

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v6:
- Inline TU102 local `run_booter` method in its unique call site.
- Rename unload bundle field to `unload_bundle`.
- Make Sec2UnloadBundle private.
- Continue GSP teardown upon partial failure.
- Store the unload bundle into `NovaCore`.
- Take the unload bundle by value to make it one-shot.
- Link to v5: https://patch.msgid.link/20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com

Changes in v5:
- Rebase on top of the Device HRT series.
- Drop the now unneeded "gpu: nova-core: split BAR acquisition in unbind()".
- Link to v4: https://patch.msgid.link/20260427-nova-unload-v4-0-e145ccddae66@nvidia.com

Changes in v4:
- Remove `warn_on_err` macro as it isn't performing as expected and
  distracts from the goal of the series.
- Add John's patch from the Blackwell series refactoring the Booter
  Loader runner code.
- Add a GSP HAL and move the existing TU102/SEC2 boot sequence into it
  in preparation for the Hopper/Blackwell FSP boot path.
- Prepare the firmware required for unloading at probe time and save it
  into an unload bundle, as we cannot guarantee filesystem access at
  unload time.
- Constrain `UNLOADING_GUEST_DRIVER`'s visibility to the parent module.
- Also write the sentinel value `0xff` into `mbox1` when running Booter
  Unloader to align with OpenRM.
- Link to v3: https://patch.msgid.link/20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com

Changes in v3:
- Disambiguate doccomment for `warn_on_err`.
- Test the correct bit instead of the whole register value to determine
  that the GSP has stopped.
- Use an enum instead of a boolean to encode the power level when
  shutting down the GSP.
- Add missing newline to `dev_err`.
- Add missing doccomments for new types.
- Use values from bindings instead of magic numbers.
- Remove the redundant `get_gsp_info` function.
- Better document Booter Unloader mailbox sentinel value, and check the
  value of mbox0 upon return.
- Link to v2: https://patch.msgid.link/20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com

Changes in v2:
- Rebase on top of `master` and remove unneeded/obsolete preparatory patches.
- Tidy up the imports of commands from the `fw` module in the `gsp` module.
- Link to v1: https://patch.msgid.link/20251216-nova-unload-v1-0-6a5d823be19d@nvidia.com

---
Alexandre Courbot (6):
      gpu: nova-core: remove unneeded get_gsp_info proxy function
      gpu: nova-core: do not import firmware commands into GSP command module
      gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP command upon unloading
      gpu: nova-core: gsp: shuffle boot code a bit to keep chipset-specific parts close
      gpu: nova-core: gsp: move chipset-specific parts of the boot process into a HAL
      gpu: nova-core: run Booter Unloader and FWSEC-SB upon unbinding

John Hubbard (1):
      gpu: nova-core: refactor SEC2 booter loading into BooterFirmware::run()

 drivers/gpu/nova-core/driver.rs                   |  23 +-
 drivers/gpu/nova-core/firmware/booter.rs          |  32 +-
 drivers/gpu/nova-core/firmware/fwsec.rs           |   1 -
 drivers/gpu/nova-core/gpu.rs                      |  38 ++-
 drivers/gpu/nova-core/gsp.rs                      |   4 +
 drivers/gpu/nova-core/gsp/boot.rs                 | 262 ++++++-----------
 drivers/gpu/nova-core/gsp/commands.rs             |  72 +++--
 drivers/gpu/nova-core/gsp/fw.rs                   |   4 +
 drivers/gpu/nova-core/gsp/fw/commands.rs          |  45 +++
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  11 +
 drivers/gpu/nova-core/gsp/hal.rs                  |  93 ++++++
 drivers/gpu/nova-core/gsp/hal/gh100.rs            |  53 ++++
 drivers/gpu/nova-core/gsp/hal/tu102.rs            | 341 ++++++++++++++++++++++
 drivers/gpu/nova-core/regs.rs                     |   5 +
 14 files changed, 783 insertions(+), 201 deletions(-)
---
base-commit: 293c8393b49c9fc017168ddb46aa2012d508c921
change-id: 20251216-nova-unload-4029b3b76950

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

