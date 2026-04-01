Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E82BD35154
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B67AE10E8E7;
	Wed,  1 Apr 2026 20:09:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OFWPATC6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED43510E5ED
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 20:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775074174; x=1806610174;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=o9dX8atNYnKOHVGjC+GGrtzs3Eybv0hsAKIbY/V4X4Q=;
 b=OFWPATC6aAGomHoGd9WhQnjGUflQGDmgQFvFTUFb063hapqxAPI8limD
 N/eRq9+cNDDyMnHD2+mTr8fcfRFyE+ZxVExOvKXAWvUZaofXLV1otbG5+
 q+R4o2iDv4c7joPLQm6zpP77eQjhfSFGSjPE5TJ7GmMd6r+c7ARPGIJ5p
 I15SFhkRqluFlXYpGnAMBRUUST5EM2WJrD2yntNcFRcCte+8V2uJo70+u
 zEYa1tmZt69sIX0BrC0eyQRyHmKG4VA7jZmGdm4WAEwcwz1K5maNAHP++
 NXnOXuL2rHV8DtAzs4K5Y/MDTU9gQh1efV6WoKqawxtb+Eq0cpRlw+eZW Q==;
X-CSE-ConnectionGUID: cieg1p4dRu6OwYA9wu7utQ==
X-CSE-MsgGUID: PgsItyFDRLOqWrABx0D4HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75300342"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="75300342"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 13:09:34 -0700
X-CSE-ConnectionGUID: /a6fYG+2RgapQHykCvQgrA==
X-CSE-MsgGUID: 7YHGOSxwTqO0Okmc624DPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="228384685"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 13:09:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 13:09:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 13:09:32 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 13:09:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBDbPBjcDT+TCPkEm/YZ0/GhxRKgFnb6EEhffKOJm8UjAFR6m0tXdGdagjE5OdY7NEsHjSMW1h4uG+N9XaJs1nKhDuJ+Q0iB+01Z03v093CVVXWRlzFX3TOK2vWl0JTH3IPYhgiBpIVZaRGxdDFF1YRLGJpsO6iBezYuUKqkyiMzYs22NayNWljiBxYVp3Sdr59kCRyGbuJU/XhI8vPzviI/NoGk+4VXJYle+lPB64RQEPlWcjjHhwBT3rbLM9gofZmN936SWHstqyys7cwSiIRG+xkBhxFXd7FpKWRRaOaFHuTN/wsK6aJgYSfRsJuers3jPFyd9Euo9CLPIFU7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8z9BWeuBuIZYRi3BYIqDqR1+TQklhIrh2/sUMG27JA=;
 b=asq9yJck+x4hRVN9B9ZapfsacVCybaNxkXsFGtlJ01ctok04PYtaEnyYO/gNxQ+6IBMNXSFKZpw0A6KFSI0Q4nBwuIDS0gNhhg3qRX2YPSl8AIcq+abjaansnbvOzCoF4m1CbJRZD81CZ95PyLCGJdau3TrhMZyYn9T0MRj7KqfaPo6gFqls8BNRn7yBcyCpZdm20pgIVbIUYaBwTv5KN8i55rxtPd0p4/aFdAvkdDXfolo5G3XUrneQHPykTIeJGBTLa2XqH1ZeABwCIBWjwCm6Z50sIoa1Dc441gHKgBLUxB12M6SFa2utWCdoI/Kq6eFwSbi3hW6Z8rySd86mUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by DS7PR11MB7806.namprd11.prod.outlook.com (2603:10b6:8:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 20:09:28 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 20:09:27 +0000
Date: Wed, 1 Apr 2026 13:09:24 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Lizhi Hou <lizhi.hou@amd.com>
CC: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>, Max Zhen <max.zhen@amd.com>,
 <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
Subject: Re: [PATCH V2] accel/amdxdna: Support read-only user-pointer BO
 mappings
Message-ID: <ac17dHiluekQgmLd@gsse-cloud1.jf.intel.com>
References: <20260331172635.3275296-1-lizhi.hou@amd.com>
 <acylqAdORtJs4cgO@gsse-cloud1.jf.intel.com>
 <1f3bc6c6-86cc-dcc0-82dd-6dfc512bd9c7@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f3bc6c6-86cc-dcc0-82dd-6dfc512bd9c7@amd.com>
X-ClientProxiedBy: MW4PR04CA0273.namprd04.prod.outlook.com
 (2603:10b6:303:89::8) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|DS7PR11MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: c68b61c1-a8bd-451e-eb4d-08de902a93f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: SW3CssSHrinHdiRXvqC+XhU5VjXxmmFQI98oSgKueM7QX/bSwOwZKOnqMnZUqZq5l4zVX9sm8/flyGsQB7iEHJpnALESlsRcqGh6HdnJx56W+BjORJBbWWB34sMejzNY0wRmgSj3NF5PHDhMXo1GpEimrPbAJDKCQavJvvoIkF0HFgZJqw2W/Le33j8dfcLQ8Zqq+1EiTi3euzbU/pVX7uLVRmh0cQCceBIzMlyyQcDxKG7eXwyce7l/YUZrts/YjmfG3EMy9jHafq/em4ZM57khPIJQqZrFqGagKckjgJiMQAwFZM2So3mdaC2A9SjL1Wn9/Dn3thVbn4U64doOkeVYuiHVpJdlgx+AnEEBv7BcerdVgmFXgKRryl8KedETYOZXkMC9bsl0sj4oBCpcQL3b/lzV287VqThoPj1uaOycv2QsO1yy8YWqAfBKbKSaGgLoqEl8e+FfNmTunxos6lu8K3J2nwP++6A9GWpHSxpiqwQ0MdbagnWEe/tXM5kNmQVQL0BK/LvOyrhMg1S5YsB8Bmryr/Sbc5LnjQjtVzFoUI7QbtMI6nvsPOJ0yVk3oiqWUlWnI0WgfkHN7MYPStMqnezcXSWPUzLBhMdbhmtJ+XETvPlclSI6VGxx4nd2SeqQOBRYKfeWP4tqRlkrZwz45a0pgCfFkNwHDLZGWSy99/xDMAOXp+ZK7sCl4FefX6+IdDCLyiqSNhPAPs8MgU/f7D6F6Yx5qPCQi7Rw38U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmU0RlQvak5tZENicTBXVmJ2WjFQS1I2eVFlWjFDWjRJcGVFRHIyVWY4ajh2?=
 =?utf-8?B?blR2WnlCR1BLWXNPcnZsSXA3azljNjcyYWRsaHJ0a0s0dDVRcWhGcTFQYVBJ?=
 =?utf-8?B?NExmcURGSGhGczIzYjltQmo5OEtoNnR3Sm5GOUdpYjBXM1J4YndXQ0ZPSkow?=
 =?utf-8?B?KzNRT2ZxUDZkVTJUN0FncTBCVWhxcUhpc3FXRHYxeGZraWZoRWdqQTVKWWtG?=
 =?utf-8?B?UndMOWtqYmlSK05ZcEhrMTVnU2MrTTh6TDgxSWNsbVVMeHJlQVBCRUJ6eldV?=
 =?utf-8?B?N1pkSmZYM2hXQy9ENlJqQTMxQUtRVEhSOHFZd1l1T3NxcXRqM096NTBnSUkr?=
 =?utf-8?B?dlZLdDFsNDUxaVJ1engvOGQzdWZzc2NzVHNoQ0lJSkpLQVBPWHM4QmtKd0lx?=
 =?utf-8?B?WUhYbmIwRlZ1TllObEZxclFQR2Z3MmN0K0xId1djVkhJN01SSUV4cndleFcr?=
 =?utf-8?B?amlhZDRjcGF3MmJGbDBkQ2lsQmlFWmJCYy9HVmg4TCsyOTYydUc4VzhWaVI4?=
 =?utf-8?B?eFhCeVZkYW0yS3V6NWNXVCtsRkVyUDhJV0ljY1lXU1lzWWRXbCswTUJIdUg3?=
 =?utf-8?B?UHRydmJYRjJodHFVYVpJUm05QkI2QjNxV0dTUnZ1VStSa0xHaTU4dEVrcXZS?=
 =?utf-8?B?MitKWjk5UStJN21RRzFkNzZUUnZCSDhsQTdLS2I5UDZFeGErRkIvL2EzYTRy?=
 =?utf-8?B?c0VIRGJXME45bVZybjBsRXpER0kyVVhvQ3Bad2JiYW9BNG1QSld4L0ErQ2tj?=
 =?utf-8?B?aXBsY2NBcVNCWnFqaVQxTTJPV1hCYnliWUN2WGFUR1JyM3JUMWNoWDJsdTZB?=
 =?utf-8?B?SlhtaUI1dTFrNGx2L3VYUzFZREdPZTZGUUs3SHlEWE52Qnh3M3NuaGtZR3lh?=
 =?utf-8?B?UHdXc0wvR3M5aEdhaVFOSkFnVFVJVTJYdEwyMHd3dWNyZlFqNEU5Q0RFUEpP?=
 =?utf-8?B?eXZPcWVSRjJPL216Z05xaDNOSGNiNXVpc3piTDJoU0kxcnNnckRZOFFMYkZp?=
 =?utf-8?B?MEcyZkt2YXhLc3VjK3c4aVgyUzE4WldRbUkyVys5TVVpVDkxdGRmaFhXRXRX?=
 =?utf-8?B?ZkdOTi9iZFlYRTFiNjNDMzVQK3FEZUs3MnNJNjZkcGZkN2RLZkpxWW52V2xM?=
 =?utf-8?B?S2VveXJrcytrU0J0Lzc3NWJCUVYwamIrTnFnck1Qb24wa2tsbVR0Z2hWRUVV?=
 =?utf-8?B?MDBXeHBleStqVXFsVW1lQkMxTXRjeG80QTNLS294RzlyYWIwUW9PVFhRRnVI?=
 =?utf-8?B?cW0vckE5RGlERmUzVnIvcmxZQlJoSWdzNTVUakcySE83blVhZlNHTFB1R2c0?=
 =?utf-8?B?ZmZyN0VLWXVBQ1kvd3F3NlJrUzVENmdXN3FYUXFUaTVqSkE4RERxMTNJZ1Nr?=
 =?utf-8?B?T1FrK0gxTHpRdEVpTXI2alUyRkEyNXJNUE5id0ZyUVVPRTdOQ0NLMnNFRFk3?=
 =?utf-8?B?Y1BOTHpJMEI2NWlQU3grUS9NT0U1WTdRb1djZnRSM3BNUXZ2WExyNWk0OWor?=
 =?utf-8?B?a3o2Q28rYTRKYmFwQzRLY215TmNHOGNVRjJWVTN0alpPcFlyUng0MGpLaFNZ?=
 =?utf-8?B?TWZQcWJVOGNpYW1kanI1d2lRZGJlUWVtWnlGWFBFRytZTDk2aXpmKzdlRytS?=
 =?utf-8?B?bnE0T2M1OVZ3S2Y5cEtObnliVFlDeHo4bUMwcFYwU0ZuNEVTRjR5Tzl4RnRY?=
 =?utf-8?B?VS9mOHhyU0M2OHR6WEN2NEFZa3R1aTNNN2lGZE5aODFVMmY3Z1BFMTFlUkVV?=
 =?utf-8?B?NjJGN2p5bE9SazlyY2c1Mis1c2ZuYjJUcmZKVHJDM3JDeVBXVTI3Y2h3WVNt?=
 =?utf-8?B?ZlNrdGMzelVXZHRTMjB0Ty92RVJNSTdVeFJYTzAvOXorUzAzSkEraXBUQkZz?=
 =?utf-8?B?bWduS2YvL3ArMTY5QjBBQUlFbW5LQnB3VjlTR2ltVjVwb1M4em13Ym5oYUto?=
 =?utf-8?B?Q3pyM3JRQ2dFZmU5SkYvaWdpTlNOaERNUzUrSXp4TWJxbFRLR08yWHpycjZR?=
 =?utf-8?B?S2RHbmw1VTFHQWlHQXNVbEFHS29pYUcvQTlOd0NkOUFDNm15VmhYQnZwT2pF?=
 =?utf-8?B?aFNJZnZtOFY1TVFoY3ZtNUdkb1ozTVlRVXBiUERXRDhTcnJpZkhtWWdPRFBw?=
 =?utf-8?B?R250THI1cHVkdDVzL3lYTVNJTEx6RmVzV2ZDb25sM1VQeE8xTFRQa2FzN0Zl?=
 =?utf-8?B?bXo3WkxTRm5wQTVtRVhvT0FqM1RWYUFibjZpUjFLMStEZG5GS3hxVVJXVmxV?=
 =?utf-8?B?eHNQTFN6NWRxVzg4ZXhnVkI1dDFJNVN6OXh4UGtDRk8vVURVbm93WDUrRTFv?=
 =?utf-8?B?WU1hdlFGaDdRTDVaSWlBYkNGdDIrK215S0ZDdnloSkNBZDQ5b2c2NndmVC9r?=
 =?utf-8?Q?DwDWkEsli7KIUYp8=3D?=
X-Exchange-RoutingPolicyChecked: LoP1QhQ4NjIRyj3y3uCp4/8WJMXd65RHOdVA3po4Dmklqc75rl1Uf6sJAvcRLAiWzmIl/tKzj6bHKVZ6WGGdej98709YAxXn9EeJ4EtrlaMAOPnWQxEKukcPXt+OhynQ2+NTbPC9rYeSFoBA15ExjFWsvGAaMib6X9a+SxfcT9RBQQMhpulTXBObaVym7LhtFVEo4zXA59ODBOZTEnrdh4B+77nHlm2eB9ZelUnRZ+3YHSevbY4oQTPG54EqkxwBTVYvuCa/UVK+/NfNJQ4/Z0qHaqjGbBmhi+PKq3XQ93j+v0BDaf471uPGgx+qZ6dd9Y9TBnBDvhDAdjO+N1S2fw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c68b61c1-a8bd-451e-eb4d-08de902a93f1
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 20:09:27.9446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZrEc9aDcuRpV42RuDH2zUeFUSZSG0wEhsks/iL9HaoL46OC9N/pasXLGE6cxsoOEAa/81G/4YiFekUymdRKhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7806
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

On Wed, Apr 01, 2026 at 09:51:39AM -0700, Lizhi Hou wrote:
> 
> On 3/31/26 21:57, Matthew Brost wrote:
> > On Tue, Mar 31, 2026 at 10:26:35AM -0700, Lizhi Hou wrote:
> > > From: Max Zhen <max.zhen@amd.com>
> > > 
> > > Update the amdxdna user-pointer (ubuf) BO path to support creating buffer
> > > objects from read-only user mappings.
> > > 
> > > Detect read-only VMAs by checking VMA permissions across all user virtual
> > > address ranges associated with the BO. When all entries are read-only, pin
> > > user pages without FOLL_WRITE and export the resulting dmabuf as read-only
> > > (O_RDONLY).
> > > 
> > > This allows userptr BOs backed by read-only mappings to be safely imported
> > > and used without requiring write access, which was previously rejected due
> > > to unconditional FOLL_WRITE usage.
> > > 
> > > Signed-off-by: Max Zhen <max.zhen@amd.com>
> > > Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> > > ---
> > >   drivers/accel/amdxdna/amdxdna_ubuf.c | 29 ++++++++++++++++++++++++++--
> > >   1 file changed, 27 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
> > > index 4c0647057759..3769210c55cc 100644
> > > --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> > > +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> > > @@ -125,6 +125,26 @@ static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
> > >   	.vunmap = amdxdna_ubuf_vunmap,
> > >   };
> > > +static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)
> > > +{
> > > +	struct mm_struct *mm = current->mm;
> > > +	struct vm_area_struct *vma;
> > > +	int ret;
> > > +
> > > +	mmap_read_lock(mm);
> > > +
> > > +	vma = find_vma(mm, va_ent->vaddr);
> > > +	if (!vma ||
> > > +	    vma->vm_start > va_ent->vaddr ||
> > > +	    vma->vm_end - va_ent->vaddr < va_ent->len)
> > > +		ret = -ENOENT;
> > > +	else
> > > +		ret = vma->vm_flags & VM_WRITE ? 0 : 1;
> > > +
> > > +	mmap_read_unlock(mm);
> > 
> > This looks highly questionable. Drivers should be reaching into the core
> > MM to create primitives.
> > 
> > I also glanced at the userptr implementation here — it’s quite
> > questionable as well, especially regarding whether notifier locking /
> > hmm_range_fault interaction is needed on the driver side.
> 
> We implemented hmm_range_fault and notifier logic in amdxdna driver.
> 
> https://github.com/torvalds/linux/blob/master/drivers/accel/amdxdna/aie2_ctx.c#L921
> 
> The code in amdxdna_ubuf.c is just getting the pages from user allocated
> buffer. The buffer pointer will not be used for device access.
> 
> Instead, user space will do a mmap to get a different buffer pointer and
> register to notifier for device access.
> 
> > 
> > I’m fairly certain that, with a bit of thought and some extensions to
> > DRM GPUSVM, amdxdna could build userptr on that layer (Xe does this
> > wihtout SVM). That would isolate core MM interactions to the common DRM
> > layer, which I believe the core MM folks would appreciate.
> > 
> > The biggest issue I see is that get_pages() in GPUSVM also performs a
> > DMA map, which amdxdna doesn’t appear to need. That should be easy
> > enough to split out. But amdxdna does need locking semantics, notifiers,
> > etc., which GPUSVM already provides.
> > 
> > I’d rather see GPUSVM expanded for the amdxdna use case so future
> > drivers can use it as well.
> > 
> > Happy to work with you on this.
> 
> It is wonderful to use a common drm layer to handle all the similar
> requests. It will simplify the driver for sure. I will start to work on
> switching to GPUSVM. It might be taking some time.
> 
> In the meanwhile, are you ok to merge this patch for now? This is a required
> feature for our product.
> 

It’s not my intent to hold up merging anything required for your driver
or product timelines — rather, I want the DRM driver/accel stack to
converge on a common implementation for SVM/userptr, since this is a
really tricky area to get right.

I’m sure we’re still missing some pieces in GPUSVM to make this feasible
for all drivers, but we’re very open to refactors that would enable it.
For example, AMDGPU is also looking into using this framework, and we’ve
already discussed some refactoring there.

Let me know if you have any questions about GPUSVM or about the
refactors your driver would need to make use of it.

Matt

> 
> Thanks,
> 
> Lizhi
> 
> > 
> > Matt
> > 
> > > +	return ret;
> > > +}
> > > +
> > >   struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
> > >   				 u32 num_entries, void __user *va_entries)
> > >   {
> > > @@ -134,6 +154,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
> > >   	struct amdxdna_ubuf_priv *ubuf;
> > >   	u32 npages, start = 0;
> > >   	struct dma_buf *dbuf;
> > > +	bool readonly = true;
> > >   	int i, ret;
> > >   	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > > @@ -172,6 +193,10 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
> > >   			ret = -EINVAL;
> > >   			goto free_ent;
> > >   		}
> > > +
> > > +		/* Pin pages as writable as long as not all entries are read-only. */
> > > +		if (readonly && readonly_va_entry(&va_ent[i]) != 1)
> > > +			readonly = false;
> > >   	}
> > >   	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
> > > @@ -194,7 +219,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
> > >   		npages = va_ent[i].len >> PAGE_SHIFT;
> > >   		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
> > > -					  FOLL_WRITE | FOLL_LONGTERM,
> > > +					  (readonly ? 0 : FOLL_WRITE) | FOLL_LONGTERM,
> > >   					  &ubuf->pages[start]);
> > >   		if (ret >= 0) {
> > >   			start += ret;
> > > @@ -211,7 +236,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
> > >   	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
> > >   	exp_info.priv = ubuf;
> > > -	exp_info.flags = O_RDWR | O_CLOEXEC;
> > > +	exp_info.flags = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
> > >   	dbuf = dma_buf_export(&exp_info);
> > >   	if (IS_ERR(dbuf)) {
> > > -- 
> > > 2.34.1
> > > 
