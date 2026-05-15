Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEB5CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 06:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4AA010E051;
	Fri, 15 May 2026 06:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VShEFBD2";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 589A610E051
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8BMKJ9k4vtsPSYeR+JUeKcsz0zgcKDeBa6ujchACTPUkWoLh+q0sO9rThc8oZjIlxcIV7ZpE3QBUxcgs/9PDV5nf0KRcFeZuot3pLzWQNrFmztl/CpJtYt3myn7P/L+Tkif9f5Y1nfHIat/VRHaCLWrYnQI4XziF8EDIWRlbtXiUkt9RucqSc/IQKBz7gJZ8vCMESBPHqYyRuMO1zyeyady0XS105ZLKpvEU8j8PYUXKmqPoCV2b/NhZf/YN4QXiD+YXvd8iRvu2SOWMfJpi7dSK7NObPzWhRwx2jpJXjQazk6uNYEQ+yvfAhtI58NeNPZ/HidO16vj1jH5V/hJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4UfFJbuII3/iWboXgKlUCchOwtg2/nmpGdAFMIWeb8=;
 b=bR7dG5Re7urRrVz/Iqn0B75E+FfvuNwZmRWNjkEGZkUtsHBCbu1minYqB5Zf6o62iedjWlvF+4ZBARYUHN4BG6Tk0bqksireXPAkWefG6oQ5Dc1rM8HObDwPXleRt2aW94dGx4eebERcSCZ1TXkmKAUqM/mNDE60KGpH7B4PEPDiEFklT9IjPeDdAKir2brGLqvJIXX+Nd7xyWkU+lCEbnitglECDz25l3dGjZwDVMzvSYPAP5rImJqCq5WfgKS4omXN5sMOEVcWCuJvHwhjzbmwQMfWzc+A+2f8Hfeb/oohBDTOND151NCwmL8K/ktRsZJ8L3OUzc1Fz3LxKOGBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4UfFJbuII3/iWboXgKlUCchOwtg2/nmpGdAFMIWeb8=;
 b=VShEFBD2Anj625dDwo61RICS0EsV3UuQ1rKS2GN1xcJFAWOY3fUoiu76p+PRZ4/MHPrkIxQRQejCZi0dR2o0gkd07bgfeIojGQXFTlknOVtaSh+MTYj5CCZ3Swe07g4QMVPmGEaRwlKTx7us2ygDXcauaGc/ytIQPfo+uFFqJPajaQyPmaVLirguzBGletZt4Hr0JrF4ghPgALEuFMY19CdAL2b17hlaycDrgI/86ZaqvJxmd7z6jaaZo5TR7qhwlKYsA6e185nvTQl0AEgE/2LVkwyugTGTnGGT+9jB2T9BmpSKVSh4+d9dsvckp/MRSAGiCLB54Zm56c2xmbMRXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 06:12:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 06:12:47 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v5 0/7] gpu: nova-core: run unload sequence upon unbinding
Date: Fri, 15 May 2026 15:12:26 +0900
Message-Id: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23N3WoCMRCG4VuRHDclM/lxt0e9D+lBkpnVgE1kV
 4Nl2Xs3CoKLPfwGnndmMfGYeBJfm1mMXNOUSm7DfmxEPPi8Z5mobYEKLSA4mUv18pKPxZM0Cvu
 gw9b1VokmTiMP6fqo7X7aPqTpXMa/R7zC/fp/p4JU0nlLHerA0NN3romS/4zlV9xDFZ/YKYOwx
 tgwDmxN77QfuvCG9SvGNdYNA2HsIJCO/P7ZvOLtGpuGGYyNkcizcyu8LMsNsZA/OF4BAAA=
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
X-ClientProxiedBy: OSTPR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:604:221::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7b6a77-ecdb-454b-0b72-08deb248fbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: P/QMc04tkSs5cTxQgjgSvctDTsdFn3kdQxNZOceVtb4Nlz/t0L4v1yx9ckYGIU2keIRyLj77nCcj+HMHqGBXtkQ9f7TPyHv1LHse3FKsQHmSExS1pu9+WTCZJJwPQQ+eILpWJVC09zFP7K9Bd40Zj9fRCFBQfmJ2BcE3BnJ2ND69t04HasRoDWnQ2OB8Mu6dAs/uMzSvteIEUBYP3qpUXawXysyLYZoZndtpLF/UX/Z2B90kfOg0V3Fy+mIwxpHy/NJmS9IP83K8/aaCtGcpX53LQajuCFgr2LMMPK6xWaXITPejla9NUDefjYmtA846e/5XZfOpCXg/SrMSVGK0dcozrnjrFF4UnDvcSdLJltsu3uAHokORUtbV64roZw/ZjNhlr7EIACOnN6vV48G9vhcEvzPVndmt0EKj6WxazrMCGOM/030eJ+yEevhRfPoINE25fTZnJp7nMW2OVEE8xvNrajobH8c+gy+OjZzQtu2CrIfOtJ0nlYzAr95jBewVQLGAfVVl9jsjcbSRCQtdqM7nxA/Z3xtDwlkw+b5j7VOKdzrZG1VfOdulWe6sMIvhV97IIkHt6pzT428Yg/scpXFTCMZxDFXVpV485M7mtIqU7ayIBRrm3c+LypThTKZRj/IaeQtXR70G+qSuKmKXG63KKPGpv+XsWLFmvJ0D/Plin/U5dzwtGR6U6UcA9KSe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEd2aEZMM2VMdStNMEk4K1Z6OGF3cFhEN0c3NktadkhnZ0Q4MzhxeUs4Wkw5?=
 =?utf-8?B?dFJ0VTBZb1Y4NzhpNVZHYjAzUFdNaTlzM3pYWE8vRHdhQUl4TFNmRk8yS0JI?=
 =?utf-8?B?K0phbHFIVFZSd2lNWmFJNnhhYjNYWFN3c2ppcXRnRktnK0xYZHpFbG9hZFBm?=
 =?utf-8?B?QVpCY2xlNVk4S0huRmtEVC9wYUpNUVptbXcza2U2bUlSMEFFWnVCVDB2N0VG?=
 =?utf-8?B?OGh0djVaOU5vTjBwQzR5S1QwbEEvYW5pekxrdWpUaVEzQjJhZER4NENlenpB?=
 =?utf-8?B?N1llR1JLNlJmODYwNG9KUWJqYmlZVllScjdCQjFtNzk5QUJKME1McURtQ1R6?=
 =?utf-8?B?WHJtcGc5UXR4K1NjSTdzYWFxem9LenhTVDUzOEcwV2RaSmFVOEF6NjNrRW15?=
 =?utf-8?B?K2ZBMTlNZ1Z1aVpEZWRxc3R2eWh6am55MFNGRjhTNG1IdjJYQkduK3g1eHNF?=
 =?utf-8?B?ODhvWnFybUhwSUJGWGpnQklGKzFIRFowcjZJNEZkSWxLZFp4R2dXWnluelgv?=
 =?utf-8?B?WmlHNFJPNExNUEw2RXZFc0JjYTJVZnBCSGlZNjNQNzZqNGNtZ2lHZHBQL1Z3?=
 =?utf-8?B?Z3dCcG9SS2o4WU9PYUlON1o3bXR2ZC9IVTE2TUszeUoyU1hrTDJWZnFrNzl1?=
 =?utf-8?B?VXdRTjB4dHRpNkF4UDcxcVZKY2xnQXdLUGs2UXpnLzhiTnczTU9ZT0tKMUZx?=
 =?utf-8?B?RGlHcjMzdElvYmppZkpVU3JmdjdDMmZWeGhJdUNzbjJyRXR3SFhWdTNWaVc2?=
 =?utf-8?B?RG1Ma2NqNExoSjQ1ZUNYcmV2MnM5eHd3T0pDT3RGSHh3eStpOUFDTjJBejh4?=
 =?utf-8?B?YjU5Q01qU3hrODBncGJnNzcvUlJCRHVzTVpTNUJ2ZVA3bW93WER3TFhVL1hG?=
 =?utf-8?B?bXdxR0t5YkJ1d3NWWmk5cFdKV1JaYVBHSjdPTG1RSHBPRGVoQWxNRXpDNmoy?=
 =?utf-8?B?UWxOSjlSbHZhd05zVFEyb25LRldMNDU4SkJ3V1NOTjJIOXVtWGs0Vm9SbXFX?=
 =?utf-8?B?c3lVRWJpbWJDQWZ5K1U0ak1ROEdUWnc5TDdLNERSc283ejFSOWowK3g1cEx5?=
 =?utf-8?B?d1laTFQ0dmUwUTlsc2s4cElpZmVYeWp0SzdZMmpWNjJ2Q0pOL0p1bXRwa2tk?=
 =?utf-8?B?R1JKNzVJczkrMy9NSlZOOTJ3QlZXYUFrL2kvVmY2WjBNQlJFdG5BNHZKZ0hu?=
 =?utf-8?B?ajJiZ2lIMXp5NVlKZG8zTzhaVjNRQytQUUljWVU4cVd4V1prR2twd0p5UEl6?=
 =?utf-8?B?UzY0Z2JnSnVSd3J6VjltdUg4OXZKNGw5RDgwaTBVNENWZ2czZkNWUHpkRDIy?=
 =?utf-8?B?c3lFMjNmVkJjOURwWTYyWXVvcnpra0M5WUdUV0huVHdOenZ6MnV2YnF1L1dG?=
 =?utf-8?B?RmpuTTA0dGppSEtKeXBISmhDRHVLcnNXcndxZjFWeXlUYnNmeUpCc1dWb3Z1?=
 =?utf-8?B?Qnh3Z0dRK1M4cHFUYzVZTEY5T0orTmZxNWlLUnMxYWNJK1hHRGZPVmNlNFF4?=
 =?utf-8?B?ZWp0clVvMlRseks3bTRFMXY1c015UXlDWjhQYThwN0JxRkdPZWFXdHZFOVE2?=
 =?utf-8?B?cXhOZExHVVVqQTExTURzUHg0b0RFNTZTZ2dVRGtSekhFZTJLS1dyMWhtQnhM?=
 =?utf-8?B?bUxlMFhwOGRnM0o3bnlMODV2K1BwZzFteW5YYTUvK04rOGlYY2dOVFhYWWxL?=
 =?utf-8?B?TmNOb2ExcE8zdE5hcUl5aW9JbGJKOWI0K01NSTQzek9wSlJENWV2SE1OWmY2?=
 =?utf-8?B?M2txeUlCb0YyM3lLTFdzbkp2VzRJNFJHUzJWSWRvQWlvQ0hjdHk5N21ZM2Vm?=
 =?utf-8?B?OEdMQlNmTTVVQjBZc1hQOThkdWZZdWtjaUVvTXdhS2FaTHJSL0lNZG13N3dP?=
 =?utf-8?B?ZldFMUpUY053VGtOeElaUEJTUFlzRUJpMWJ2RUw4MHN3QzlFQVFLVEtld3pB?=
 =?utf-8?B?VkZTdXNNdjNIekNKdjVSa3NWeWs5M1JsUEVlamx4a1AvYlZIcDRRYURsTFpM?=
 =?utf-8?B?UEtWSjNSQ1lVUU1KZFJaR3A2NG1tZG9Qd0ZqdW9XUlg1dW5uUDhrMEVESUE5?=
 =?utf-8?B?Z2ZMUU9aaDlZRnFzS3FZSHVqVWxaRW43Y05EdVVybkFzNXNSUWFIMFZ3Y001?=
 =?utf-8?B?U1FYVEdoNzBZNzFxaWJCY2Rpd1I2WVR0NXBaU3M4RU82Q3dJNnNKUGtjeUNk?=
 =?utf-8?B?YXE4bXNpTitzUjJyMm5vTHpBQTFDOEZWZ05DVlNjMGJJeWdyRHZZUWt4YnpV?=
 =?utf-8?B?MGNDOGI0YXpvenJEaUgybnBTVWhkWCttVWdiVkRjRUE0QWppSkhSVTdQeUlr?=
 =?utf-8?B?SzZGNnlRU3pLZzBNL0RCU0FTZjQ1VEx6RlJMS0gyQ2FkSmZVTm0vRDBENEti?=
 =?utf-8?Q?6L3frwJujHUddT6gn2VBy90NHXNetUS53j/3YdbXhJq5g?=
X-MS-Exchange-AntiSpam-MessageData-1: qrcTvRG60MWt8g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7b6a77-ecdb-454b-0b72-08deb248fbf7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:12:47.0957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpl/fyji2a+CnoOr0HVHzT54xS5t+bG0toGfaWc22Fz7ag0SJyiygqpniwCfBufLbJ7rNVcwD/9paKMJc19hNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
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

This revision rebases on top of the Device HRT series [1] and addresses
the minor feedback received on v4. A branch with the series and its
required dependencies is available at [2].

[1] https://lore.kernel.org/20260506215113.851360-1-dakr@kernel.org
[2] https://github.com/Gnurou/linux/tree/b4/nova-unload

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
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

 drivers/gpu/nova-core/driver.rs                   |   4 +
 drivers/gpu/nova-core/firmware/booter.rs          |  31 +-
 drivers/gpu/nova-core/firmware/fwsec.rs           |   1 -
 drivers/gpu/nova-core/gpu.rs                      |   7 +
 drivers/gpu/nova-core/gsp.rs                      |   4 +
 drivers/gpu/nova-core/gsp/boot.rs                 | 252 +++++-----------
 drivers/gpu/nova-core/gsp/commands.rs             |  71 +++--
 drivers/gpu/nova-core/gsp/fw.rs                   |   4 +
 drivers/gpu/nova-core/gsp/fw/commands.rs          |  44 +++
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  11 +
 drivers/gpu/nova-core/gsp/hal.rs                  |  92 ++++++
 drivers/gpu/nova-core/gsp/hal/gh100.rs            |  52 ++++
 drivers/gpu/nova-core/gsp/hal/tu102.rs            | 351 ++++++++++++++++++++++
 drivers/gpu/nova-core/regs.rs                     |   5 +
 14 files changed, 736 insertions(+), 193 deletions(-)
---
base-commit: 84d984f9fe9363f4700e20f7c95b2da67fb2fe63
change-id: 20251216-nova-unload-4029b3b76950

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

