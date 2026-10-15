Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9D3CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADB2010EC1C;
	Thu, 15 Oct 2026 16:10:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B4F10EC1C;
 Thu, 15 Oct 2026 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792080625; x=1823616625;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lEHt1lS4Q7tGXxDNROuInU2jXMA71i8gfs1lYqY2HPo=;
 b=nKpzet2RR7WUwEEts+JjkGBZssSAiQG1W4YAMZmqTW06ZH4uiTlko3BX
 vHxnfjc/a3id0CBrMF5qWygMAnMNNrXK8OnqWNor5/echtds4K+Bz+aXz
 r32U2YfyIejHX0TUuV4Vx2jdY5asM7oIuo/7MvSucGErqZoXcB5iE9xTw
 6uwIzIh8D7ST0alaXrR2VowCz4jheDzbBrfFpkrjEeMLR+d+Yq98qsOve
 Zv8n223QNJj2Ctxgx2S3tHErnsqpj3kv8fMXa44jnnkc/1C+bvtVnWb+W
 SJf63g07mnF6ASzVMgLTFC/CHpgFVwibaigiHbS3+w+vTPx5BJDYYeW4U w==;
X-CSE-ConnectionGUID: 3LOFxDzKQVS84nOXtBTdVQ==
X-CSE-MsgGUID: PmK8J76zQEi8ZQgqgMn/Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="738573"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="738573"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 09:10:24 -0700
X-CSE-ConnectionGUID: 80v+BDsnRDmQRGIpSm3K9Q==
X-CSE-MsgGUID: XOqngdLxQT+2Xq7F57ob1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2086959"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 09:10:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 09:10:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 09:10:23 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 09:10:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JedSokVy3XuhtBv8RR7DNAx0MJpvL7idSceOrYl9CqgP7SbwdznkXXv+AsJfNtJjV5TaGLNeiS0jyLG796sw0F7JBJyLLVHJ9e/qpxN9kYOsRj/X5rGXkf/+bMYndQGpcIKeBS/eZTEXqs3Uclr+rlIZJW3ew5tVCET61InZjgn7t7E0mSPju+w5gUjX7/okLqpC6UdhSeo5ynI8/Xm+1pNj3/QFmbM2jNwvNm7qiHMcuarR23Cqjv9TNXWztgvaDDz5zuwoPsqRStEQNVTdGt7pN5WYLp4MQuLbr7dYdNpYDDVbb52BoCMZMbW4biJOPcG9HtKH2RQ7rGNKo8nVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxhjNvNGJ5GwUaOebvsNeuCWKB8ABXYun+/koUimN6c=;
 b=mjzN4TZyUZDcl4ymIMuRduGsweiFUr+1b0kJ5bolNRVdzrnx1fEe/keQvtosZFf4ivHRHZVm02BqjedMbEXngq5cDl7hzSHWyryaZVo9nHdkGOCTSGNjJBl6CNzDwcR5aWrajoxvTxVMvWXQbB/RptPe4gjza0y9GmuWJVmuC+nrT81LAHTisOtQM0skyPuXBtcdKKTEVnu2+FDegZxw8VplxCUgmIcXUXefeOvFX24CqTO0AXAlbAVfdj9u+rodMGC09ATR6GO3Lnsqa/VJmhjqNok3svUKgO5aQTvHEXvADOWqRKxMftskNqslTOjGhYXFd0Yz20Op0zko+j7Psw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB7181.namprd11.prod.outlook.com (2603:10b6:8:113::13)
 by PH7PR11MB5959.namprd11.prod.outlook.com (2603:10b6:510:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 15 Oct
 2026 16:10:20 +0000
Received: from DM4PR11MB7181.namprd11.prod.outlook.com
 ([fe80::89ec:90c8:3170:5f0a]) by DM4PR11MB7181.namprd11.prod.outlook.com
 ([fe80::89ec:90c8:3170:5f0a%4]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 16:10:20 +0000
Date: Thu, 15 Oct 2026 12:10:17 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Zack Rusin <zack.rusin@broadcom.com>, <dri-devel@lists.freedesktop.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, intel-gfx
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: Nasty console and xe driver interactions
Message-ID: <atD66da36wMZ0gie@intel.com>
References: <5e79d3c0-5b2c-4e6c-ba38-3b723daf7109@intel.com>
 <atDXDlI-EhrA791a@intel.com>
 <d4d5302f-9768-4122-bbab-4384ef7aa9fe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d4d5302f-9768-4122-bbab-4384ef7aa9fe@intel.com>
X-ClientProxiedBy: BY3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:254::23) To DM4PR11MB7181.namprd11.prod.outlook.com
 (2603:10b6:8:113::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB7181:EE_|PH7PR11MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a57c4a9-74ad-4e8d-b18b-08df2ad6cf50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|10067099003|22082099003|3023799007|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: spUC2bxxSnc9Xuhou+41SOeG610RN5X4HN56LsFqp9CQHuX+hjgH5hcASvwXS4wPGPJJFKYuHSn7R5UfFUmQ63lqkK/VYSHTFHTPi5AlENo81AbnQ/cxA2c4sFZJs5X4jn/zyu5PKbom5if/deQ+CoJFtcfNAnPxsAYtxWkgjS5mga00gZ7zDDBQkEF6U8H+1MZAxzKf7Yhv8WeLFNkG9bS0wQB4zjtKbjEiomZ1iPh5CWKPcquYNA8ypefxlm+BPoexlkQOUTNvvh1m7fMy/BBW1H+R6FcbirASvpzwphxk0r2NRfiuJMAQ3EzpicwOL4dDClmt8bHQQeCJNudQf9DR1cyw3yQjR3SvI/zfm+zkvP7Mr06FRQkydPifxkRv85R+f0/VRu6obiLatiV27QQkyFLErrldqccXALD0dgeTJtdSelDmS83Iniwt7TJ4NOhf7ZJ8oHXZWEzHGi+mZn/k3W8ACe5lydZCda2IqtDC3cphB2q1Pr28IbrpzIlXXzHgV0d9+/tl9c6kbUBSUNAjs4Ss26WZbIizzCDqZs2KkCQZh1/XnV3Uriqi7fTjOtMzvCGQvBi/WDSQxpUbteWBi1zlb141l+tGFbmIb+siLMhiVvgwKpTDpCiqjo+V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB7181.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(10067099003)(22082099003)(3023799007)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6V2Ew4bccqsGvny4tDujo6nTT/ZUcbVe3i5A7yO4RUgXSQi0Vm9Zu4NdCIht?=
 =?us-ascii?Q?xlTwGhmzWTC2VDMOyw+0fV2OAc8c5B1YkZJmuLem/1TgMZZKIBhn1qRzpnQS?=
 =?us-ascii?Q?UcHnmVvXumeoS+ND/57iGyFEDpSE7TN1LN/L0ai4ukC26PdhujmTUhXtHjI2?=
 =?us-ascii?Q?ZzQuyeNDZ4lDTiHF9XI/sioJwwsuyslbDlyNaq4Vn58J9RX4hnWWXEXk3OXu?=
 =?us-ascii?Q?QyDjpxwQFRmQhqbfeeTNqtBW4MVDLzCDlSeb2yVk6Wzi9Wa5L6xjkJC09VqG?=
 =?us-ascii?Q?OKb5a7Ax0M4PwdPXi9xJptiOBkrcBnnFXnn/nwgsn7poSAiod46oT9R/KwOF?=
 =?us-ascii?Q?YiQUVHq3d9vt6SjJZ+3XzDvqf4kjroBg0hH/0kUhZwi26BRbWPatSToA1Qdb?=
 =?us-ascii?Q?Gxwj9+dv+khxlJ+Ur7Hk3ImbYibCmlnRqAyjibMVdjP09AqDooZf9C1Q2LHQ?=
 =?us-ascii?Q?dtc06fa+U76fua80GoMCnLQEKWOV/crJljzkmKqSRTGozcZwYl0feLk344t1?=
 =?us-ascii?Q?E8P4+8430Kr4r9/e93Du2cNVZq+JCP/SE8Pq3movgwjMs2fA/lTZBxZKhxkJ?=
 =?us-ascii?Q?pwOfQcZ50ATfMC+qF5KgmyTSjRfGrFwXAdgz1pjk/983c/MohwlmNc/+VHGX?=
 =?us-ascii?Q?FLCA9Q+LVKfRojLft6oe1+C4FunOIyEqkmZAuc/GQ7r+NQi7V0oCqMs27TG6?=
 =?us-ascii?Q?KJp64GFBVZypwZh+9O21fw6iM1GBE+eLIPmqnH6F1NdQaYXL63a34TjXNGIx?=
 =?us-ascii?Q?qudVo6fQ4QRiKeLXqpTgr5PsxYZCtX0905HYUUFr7ZK5NAUzB2lwDRIe8WPp?=
 =?us-ascii?Q?IGXDCrnars/lkVwQyDYE4lhqo4HA/QWWXvwz9HnqwMmI8+HzRH4VZTnqFUVC?=
 =?us-ascii?Q?qzvtntu/4x8FA6BQt5ZDiGiqiqhbw55UeHaSIhsHGHMzhi7aXmiOJEPRBgL1?=
 =?us-ascii?Q?Dn74MRDm3uJSk7wJdmujBBAQwJuzXfKYMTBPaFeRXdKuXvlyqndzbEBQ/Wlf?=
 =?us-ascii?Q?pXwxSL+PTi+qbeVJQ18YjTsHg78pYhfrN+PGNEgRowXBHuCYuGp3UV5IULID?=
 =?us-ascii?Q?If0WaczPlJSb5dKmDSfarQzecXAEIFvwWfeyCPbM0SdL8zA6aMGQwfNDNCJW?=
 =?us-ascii?Q?DRRyo0zxhP0atTbHwfV5SPLFHoV6kUrzKO443CSy5FH3RLl8O6CruCHqt1h4?=
 =?us-ascii?Q?im5PkCSA8+9AAJ1upUZm4Ex0rhtCBYGBh3CKInSQ8s7N61VfOTf99XWjrBCh?=
 =?us-ascii?Q?RnrnQSrJcMqkzR/jDLiEAKoxK88FO2t4yH8pVoqtozVi7Lg0/N51DjDkv+cP?=
 =?us-ascii?Q?+SO3Y3I9WivRTXXmaKyCkM/4mB9xZa9uU/E1cIoYGaDwJj15liAZpuwz7z6K?=
 =?us-ascii?Q?N1jAfQ6XIje0GrrmcniJR1Qyh3zMRZQkiIWUfAPhry07r22sy4YA1iHyso15?=
 =?us-ascii?Q?MnDPfB/dSwx1h1tLICZvvagKpyua//+ClgaFjRwwYDaI+wyGEtwae13vDZi9?=
 =?us-ascii?Q?estfGUBhIySc9qx8nlx3uDdKAjKa1/pIgtUYQerrvqGEaz1c27C9OcLPCBNV?=
 =?us-ascii?Q?kaOEvMlBnJqFVwwhM9u0eQYjurfObNzjUfw4G07IIEQeBJS+4g22wVb7JN5B?=
 =?us-ascii?Q?T0z6pFeq820SskBCpPpKgBfujxH3QYvOnzhr6hgfVcKk/QcazzI6i9l2ho6c?=
 =?us-ascii?Q?ccXfKmW6O0zBILdwFTCrmygXJsUfVKVVcH4ln5Mgc55eS+tudo6GS3Vuf5ZA?=
 =?us-ascii?Q?n3Y+7j42UA=3D=3D?=
X-Exchange-RoutingPolicyChecked: o37b5M4445nWzvXO9iiNf5MrDWQpgMcYrVRH0TaOsjM+iK0usdytNyr9a9BWrwBe4/mCsm8q6FLz/FX56qmcuhbmQj1iNaWu806jVy2u7guiEPxZT29JLSZ4dU4Lpd6mGI1QebDWVtj1j98i4rKv7+9HYyRX5TaZtQmKvDKsTgdP++OaEBq8m+2jl0rsN2pQFwFvaK/v/jwPKEofCdkGsnllfbagnsCjJzBXFwaT2lZWa9o46OBkEpRQ/fDRa96M36C5rEk/c8LANpuNzufHKOFPTzigbPMRU8TrruwAIZ8nAebBgRDPdr+FC6FnHegLUfuTH3J7xUESfNI64yiX+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a57c4a9-74ad-4e8d-b18b-08df2ad6cf50
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB7181.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 16:10:20.1607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nX8lShCgFR/ztfBqPNXShIOrpGZmai3HalS8llmVxNEJe/y1zfDozl+lnMbI/gaUcabTFmrZPW5y1AZHPNPpWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5959
X-OriginatorOrg: intel.com
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

On Thu, Oct 15, 2026 at 08:30:42AM -0700, Dave Hansen wrote:
> On 10/15/26 06:37, Rodrigo Vivi wrote:
> > So, perhaps what could be done in this specific case while we don't have
> > the proper one is something like trying to pre-fetch the mandatory fw.
> > Before we steal the fb. Something like:
> > 
> > (Untested warning)
> > 
> > https://github.com/rodrigovivi/linux/commit/5589d2883a604d52e89f44620e16d16c7fd278e8
> 
> I threw caution to the wind and tried this. 

Thanks for being brave! :)

> Id didn't seem to help. I
> don't seem the messages about unregistering the old console, but I still
> never get any output. The only "xe" gunk in dmesg is:
> 
> > [    0.739464] xe 0000:00:02.0: GuC firmware xe/ptl_guc_70.bin not found, can be downloaded from https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> > [    0.739501] xe 0000:00:02.0: probe with driver xe failed with error -2
> 
> BTW, "xe.force_probe=!*" on the command-line also gets the output back
> to normal.

the force probe proves that we can still probe safely, but apparently
on my first attempt I missed the fact that pcim_enable_device will
touch the device and register a pci_disable_device that might
clear stuff and mess with the VGA fb...

Perhaps if we move just one step over:

https://github.com/rodrigovivi/linux/commit/616cd8c1b4d4414cd1f7ad56fa5d8abd36d7968d
