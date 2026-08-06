Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8547C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9CDF10E322;
	Thu,  6 Aug 2026 11:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uuIcYavz";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010059.outbound.protection.outlook.com
 [40.93.198.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A531810E322
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 11:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saqpxNjA2QG4VGf/jMad78DCQcy2AcXZZxM1uXI2QYC51tH9LCJ82hwLcnHEvK4T/iVYZv4IJvdS/Z5XD3i++74WFBVV5svXop+/24uWyUc826KCUPzqBm7WGsq004BkTdoBMM0Kbnp9hm7FORKDN16M9xJVXawgNVPkE3KmLExng3plPr133e9d1WhusHIydIUZZEcVMLqbHQIgVI3KOMqCXb1/BbiHO4n9LTtCztoZRzDzQ4oxkSP2zI3vdCJt6XDld8qGbGikbpWG8zssHjAWvHKFPOqT7EAimTz1jP59E/uleAPPK+4bFs2QMIuB/T1lhsGQyxARamfVX/I/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnctqB0PwaBZuKWevvs9BaweXH1ecqdC4Q3vgrP7LLg=;
 b=dPEpOwilfXUccp2sef5hCKdPOQU/UEqDpU4SNpyzWCg6os8NiqnTOjvYXvfQF359btMIx5qHGkZzhDzH9eOg1/6QflOysee+V7bhjlDt3zzEO98QiHtezKCJpon88VuJsG/3a38+Q3gK6D53EVeRety5DymOKUG7L/1c2CYR3v95EPEtivHIALDB70zLezHwbChxsk1gK6oFKeepp9Dewm6tbAsh4gfmlHY0qbZ6XnqkXgKfjwaWJX8C3xIR4o8gJDIEn4lZsVYRbbkfHA6CxR7BRvbAmzkBOPNX+8ePar1wuKjKU0uL5BEWrFMpxRWaGaSAOmvoPPvhzw5NPqYJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnctqB0PwaBZuKWevvs9BaweXH1ecqdC4Q3vgrP7LLg=;
 b=uuIcYavzN2tlAhLkSmidMtuQl1De1AOXs/WkNdRvraOSbOBjjKkdKJIfmMGTc9AqMEgJbDkYPWbKXdOkf6/AgwZad2+DErN6uG8ojBhVJQJHe0eFpsznc/7kAggNr/9J+jb3WYJ5h2PFxXjjPK9fzEWK/5pJLNl82bdA5a6dCKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 11:52:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.021; Thu, 6 Aug 2026
 11:52:10 +0000
Message-ID: <5f90bb35-994e-48bd-bf49-3001dcefa2ee@amd.com>
Date: Thu, 6 Aug 2026 13:52:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Synx : global synchronization framework
To: Pravin Kumar Ravi <pravinku@quicinc.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Faith Ekstrand <faith@gfxstrand.net>, Simona Vetter <simona@ffwll.ch>
Cc: "linux-accel@vger.kernel.org" <linux-accel@vger.kernel.org>,
 "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
 "andersson@kernel.org" <andersson@kernel.org>,
 "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
 "konrad.dybcio@oss.qualcomm.com" <konrad.dybcio@oss.qualcomm.com>,
 Rajesh Sastrula <vrajesh@qti.qualcomm.com>, Trilok Soni <tsoni@quicinc.com>
References: <BY5PR02MB6866E35A2B4241CF3A728A99D3D22@BY5PR02MB6866.namprd02.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BY5PR02MB6866E35A2B4241CF3A728A99D3D22@BY5PR02MB6866.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 634cf7cb-239b-411a-ca29-08def3b125eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: o3bj9mu5xqYvnG7jLvAJ+w8thn0RNXIkVoGtZ+gXn8MptuXbgp9wIPCmy2kcnBVY/6p+ynaz+O/xJSqqjD0p+p2CKql6CmwxfeawLp8z52wu2k6rFXIXVT3o2OxIrBk0a+Mv7WMSEW91VquFUKH+XSgV1AFz7D4/ZzvEcHG6SsxmdccCO/9CYxlM5ObrSuKvegK8YcMj8F9JORZVDEYIv6uWV7b11slCHjQCES8x51Ew/BwNU3bBVxNA86fmv+sqBTTb+Mz4bT40/KUSmbZSAzUQJIzYmTrtK0gou+/km7j8wPwBl0St1N61vhJDJN+FrtoIh4jDe6K9cZZ/RWde+1YQLo8EL/4/HdcYMIsU/RAD72ymvNI/PmyHi0Ag/ln9K0AnEBdDiK/985UUEcJAPFykJX8jJZrsJnAmql6+7SSSIxZjiNBtfeFNi7FNUutbraWz23ZWusbN5c7h8/Q63mWrjQqGl1NCLEJgw3/lYS2WiE2beDoLVmy8sc13Ac8nYp242YTt+lSpF1DztOHuIPakv11G8C6kHdlYNOLhJdPFA/2PL+93cLfXlfZtSthsR2U2po3WL1wGBVppLjdObY3x8/JxWlOS/grGlOBbXhcNNr0G/Hfau3Aix2JPaZPEDYQecztcT7/GQhdH7oKAn6q8+6+3q/5I4+yWS8W2di8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3FEa1lIc29zTkpta3hVT0hrdmR1SjVnOFlRTkQ1enl0NWdkTitPZ0VQL0xq?=
 =?utf-8?B?V2pyMkNKWXRzeDBHZ21EeC9OcGtlMnRHY1Juc3dIUFdPcWZUTFVFV29GKzNu?=
 =?utf-8?B?QmtxR05tMGI5QlB0K1J6aDhUcEdYYU1OSnJuY0gyYmJuUi9kNjZOblF6WUJ2?=
 =?utf-8?B?QTlhM1VNbUxtRnBydlpJZm5Vdm1DeVlObWNwOEE1bG5ReFZ1RXRmdW1WTVpv?=
 =?utf-8?B?dklsdnpEczZnZzVla0IreXVVcnBvY0ZremJCaTU5QnBJcWFsOUpFWnd1TTcw?=
 =?utf-8?B?ZGxOOHk1aWN1YXMvalptRmFpN2JHVVZtN3MveHZoOFVmZWpaYjFZNUErQ202?=
 =?utf-8?B?Z2c4VWlLbEVPTDR6TmtTc3I2czdxY1pQUDFUMDdCdUt2Z3FwNS9VenA3S3JJ?=
 =?utf-8?B?RjBlc0FydG5XUXBkK0FzemUwY05CempCbWIyMTc1ckd3NXVQd0Q5ZVlpaHBo?=
 =?utf-8?B?RnIzdzlBTEFxNFJLSXRiZWRNVzMxajQ3TkpER20zeXpVSmF3U1M0Y3dFSFFs?=
 =?utf-8?B?ZEtuZGZXNjFEVjFHWEd0NTJ6NFdyMmNZQmxiRThMUXRhN0tkUTNOaTAyamEy?=
 =?utf-8?B?MGtvOWRwaDFvNWN1SGU0ZzBCcjNySE54eUdWNkQ4MnlCU0diRlBUS3VGM0hj?=
 =?utf-8?B?anFnRzg3RUdqVXNMSExQZE5TYU5kZFQzWFhnMEx2SUwwd2ZZcllKRU84TDZr?=
 =?utf-8?B?QkRIM2hnSXpzV3dwbHhjQmFObDNtSmtETmFYWUczS21OOXcyaUorUHoxMUZV?=
 =?utf-8?B?R0dZMmwwTFpQKzFNYlhCQStrcHExSXVISXlyK2ptK3V6bGJ4ODRWYjhXV2xD?=
 =?utf-8?B?a29iV25jK2dnVU1sTEcrRWtaUVZOWkpFdVlxQktUN1RnWEh0U3FpQmFLbjVN?=
 =?utf-8?B?cURNbDRXSVFZYzNDK1JCbEkwQWx6ZUEyMkZ1SEZrbUd5Q2s1Z3JqZ3VpeFZp?=
 =?utf-8?B?emUvT0YxSkYyTVNyYWdmV0labU9yVzdSY1JsRCtrUzVsVGhZb2NoMmJ3aHJG?=
 =?utf-8?B?WEVsZWFraGxGc2FtTUU0MGZRVWRLYzVsaXluOWhIUFRWNjBvekwrZDllTFJj?=
 =?utf-8?B?NTY5SnBhMnA4WmpmcTR1Mk1LdmdVOXdEZ01OOXhqVkdhNnVqZzl3NHFmUWw2?=
 =?utf-8?B?OVJEQTE1VnFjY0ZwOVJJdnJ1MjlyLzhuVm40R0FBMWg4QWRrS3ZBaFYrQUVV?=
 =?utf-8?B?Q3F6a3hUeCtTeFdodTlRNVNrUDhtckZuTmczaTlNRXlOTzJ2cWJKT2Fic0pP?=
 =?utf-8?B?YU1FeitPNTcwQ0Y1b1lQVTJ5UFE3VHc3YVlRTlN1czRIV3VMdWdOa0ZVcDZp?=
 =?utf-8?B?Y0Rtd1BmYTVqNUJMaFRJQ0pFakJlUGs2VlMrd2cxcWR2M1dVOHEyemlzallJ?=
 =?utf-8?B?d1htdk1OQnBQd3hoelk3K2lDWGVUM2N2T1pjZ2syKy8vUGl5UjVITmlycjdw?=
 =?utf-8?B?ellHRmFWa0VUQUlGWmRSU3ZYVGNXWEk0N3lIK2FMeldPaDNmUlVWOEZFbWhY?=
 =?utf-8?B?UFdIRUhESVNObEFkQ3RRTkhmUTJnelRZK00vTXdIdzIwVmRxS3VHV2lhdVNw?=
 =?utf-8?B?TlMvaEZyNWt6N1c1ZVRRWkNFUmx0MzJYdHc1YndGTXZQaGlPOUE4VG9TREdt?=
 =?utf-8?B?ajVRZFRyZjFxdUcvbXpDT21ibHNkREozekVZeUg1MzZRTi9OSk9PUVFKdXR1?=
 =?utf-8?B?OXZJb0thV3ZMdlpKTENxNGFJb29sdTZsYlo0VTgweTR3VHAwOWhnK0Qzby9E?=
 =?utf-8?B?eENHSzFDclNDbEtycXlHS29CYThFNTRuMjlaMUhVQlpNVjVGak16YnFEN0th?=
 =?utf-8?B?aVlRcUhJNVpQa1FucnJwOXdSZ1BMcTNlYjJEYkpwK2hKMmdmV3YvME1mbDU3?=
 =?utf-8?B?N1lZV28yR3JKQkZEQ0NqNzZqU2JKYmRKK3R2Q2xqcjdjc2ZWdzFNTEwzVngw?=
 =?utf-8?B?Si9nekltN3dhdHF1L0pFUlFpWVZZOWxWa1AxQnFQWFB3eC92YXRhQjIzUGxw?=
 =?utf-8?B?cUxhREJMa3NUYTFKd3l3Wk9EWkc2OVRNSVhmOU1KcVIvRUV2OU9LZnhybWRz?=
 =?utf-8?B?VlEwOEZ4RFpBUjZpendYdjVkZWJjS2ZpY0pZRU1ERS90Q0g4WWVSN3V4MW1T?=
 =?utf-8?B?Tlpaa2dpQ2xHYmlFMUtYZWc5NzVzajhXalkyZWVNQkJGVUpNU1FlREZYeUlB?=
 =?utf-8?B?d083NExCbjNjMDdsM0paYnBlSFU0bFZWUWJoRDgxdjN2ekZkZGxXclo5dHBt?=
 =?utf-8?B?dU5KeVA1Y0JvM2hRQUYzbkxnKzlqaHZJRVRrcVJtYVViajJhalRNYmxFditO?=
 =?utf-8?Q?WFB6jJnybdCt8hemMv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 634cf7cb-239b-411a-ca29-08def3b125eb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 11:52:10.5778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2vlkD9QqblB6E+q2KvORDd2cygTFex8Lld5/mJVXz2Dwl/NhCwec+eqT9ZIx164
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602
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

Oh, well history repeats itself.

On 8/6/26 06:30, Pravin Kumar Ravi wrote:
> Hi all,
> This RFC is intended to start a design discussion around Synx, a SoC-wide synchronization framework used to coordinate fences between Linux-hosted clients and non-Linux execution environments such as remote processors and firmware.
> 
> The intent of Synx is not to replace dma-fence for existing in-kernel GPU/display style synchronization. Rather, provide a global synchronization mechanism spanning multiple subsystems and processors, while still integrating with existing Linux primitives such as dma-fence and sync_file where appropriate. The solution has shown significant power and performance benefits in the last few generations of Qualcomm mobile and XR chipsets, and is gathering more use cases. Also, the solution is SoC-agnostic, so other vendors can adopt it in the future if interested.
> 
> 
> *Motivation*
> Many multimedia and accelerator pipelines on modern SoCs are no longer strictly host-centric. Work may be produced, consumed, waited on, or signaled by multiple execution environments, including Linux drivers, userspace components, DSPs, ISPs, NPUs, video firmware, camera firmware, or other remote processors.
> 
> dma-fence is a good fit when the fence state, callback list, and lifetime are owned and progressed by Linux kernel participants. However, for cross-processor use cases, a synchronization object must satisfy properties that dma-fence does not currently provide:
> 
>  1.
>     *Cross-subsystem visibility*: A fence created by one subsystem must be importable, waitable, and signalable by other subsystems, including non-Linux processors. struct dma_fence is local Linux kernel state and is not directly visible to remote processors or firmware.
> 
> 
>  2.
>     *Point-to-point remote signaling*: One subsystem should be able to signal another subsystem without interrupting the Linux host CPU every time in the signaling path. Since dma-fence maintains all waiters in the Linux, remote-to-remote synchronization has to unnecessarily interrupt or involve the Linux host.
> 
> 
>  3.
>     *Distributed lifetime management*: References may be held by Linux and non-Linux participants. Any subsystem must have authority to create and clean up fences. This requires lifetime state to be tracked in a shared/global table, rather than being owned solely by a local Linux object. dma-fence lifetime is centered around Linux references, which does not naturally model references held and released independently by remote processors.
> 
> 
>  4.
>     *Race-free global synchronization*: Registering a waiter and observing signal state must be atomic across participating subsystems to avoid missed wakeups/signals. Atomicity between remote waiter registration and remote signaling needs a protocol-level guarantee, not just local callback handling.
> 
> 
>  5.
>     *Subsystem restart recovery*: If a remote processor or firmware subsystem restarts, references held by the crashed subsystem must be released, and waiters that depend on that subsystem must be completed or failed in a well-defined way. Subsystem restart cleanup is outside the dma-fence model.
> 
> 
>  6.
>     *Global composition*: It should be possible to compose fences that were created by different subsystems or processors into a single aggregate synchronization object. dma_fence_array can compose Linux dma_fence objects, but it does not by itself solve the composition of globally visible synchronization handles created by different processors.
> 
> 
>  7.
>     *Transport abstraction*: Remote signaling should be independent of the underlying transport, for example rpmsg, mailbox, GLink or another SoC transport.
> 
> 
>  8.
>     *Linux integration*: Linux clients should be able to interoperate with dma-fence and sync_file where that is the right ABI or in-kernel interface.
> 
> 
> 
> *Proposed model*
> Synx introduces a globally unique synchronization handle. The handle indexes an entry in a global synchronization table that is accessible to all participating subsystems. Each entry tracks: a global handle ID, current fence state, the set of waiting and subscribed cores or subsystems to allow point-to-point remote signaling, a distributed reference count, and parent/child relationships for composed fences.
> 
> The design is organized around four components:
> 
>  1.
>     *Handle and session management*: Any subsystem, Linux or remote, may create or import a Synx handle and hold a reference counted against the global table. Handles are destroyed by the subsystem which releases the last reference, regardless of which subsystem it is.
> 
> 
>  2.
>     *Transport abstraction*: Remote wait and signal messages are delivered through a pluggable transport layer. The synchronization core is not tied to any specific backend (rpmsg, mailbox, GLink, etc.), enabling point-to-point remote signaling without involving the Linux host CPU when both producer and consumer are outside Linux.
> 
> 
>  3.
>     *Linux interoperability*: A Synx handle may be associated with a dma_fence or exported as a sync_file, allowing Linux kernel drivers and userspace to interact with Synx objects through existing interfaces.
> 
> 
>  4.
>     *Fence composition*: Aggregate fences are modeled as parent/child relationships between global handles. A composed fence can span handles created by different subsystems or processors, and its completion state is derived from the states of its children in the global table.
> 
> 
>  5.
>     *Subsystem restart recovery*: When a remote processor restarts, the global table is walked to drop all references held by that subsystem and to complete or fail any affected waiters according to the configured recovery policy.
> 
> 
> 
> *Possible initial patch structure*
> If the overall direction is acceptable, an initial RFC series could be split as follows:
> 
>   *
>     Documentation describing the cross-subsystem synchronization problem and the Synx object model.
>   *
>     Code to manage Synx sessions and handle lifetime. And synchronization using wait and signal
>   *
>     dma_fence and sync_file interoperability layer.
>   *
>     Fence composition support.
>   *
>     Transport abstraction for remote wait/signal messages.
>   *
>     SSR/restart cleanup hooks for remote processors.
>   *
>     A minimal Qualcomm SoC integration backend and example client.
> 
> 
> At this stage, feedback on the model and layering would be more useful than detailed code review. In particular, we would appreciate guidance on whether this should be pursued as a Qualcomm SoC-specific driver first, or whether the cross-processor synchronization pieces are generic enough to justify a common framework.

Well to make a longer story short what you describe here was the original dma_fence proposal from >10 years ago. We fortunately rejected it already back then.

By now I think most people in the Linux community who have worked on dma_fences agree that stuff like that is an extremely bad idea.

First of all some of the stuff you suggest here go strictly against documented dma_fence restrictions, especially no point to point remote signaling! dma_fences have a huge interaction with Linux core memory management which makes stuff like that impossible.


What you can do is to do this in userspace with DMA-buf and user space fences, signaling points etc... Take a look at how user space waits in XE work, how eventfd works and ROCm events work for an overview and maybe some starting ideas.

We could certainly build a framework around that, especially eventfd sounds like a common ground to most drivers already, but please stay away from dma_fences when you want to do something like that.

Regards,
Christian.

> 
> Thank you,
> Pravin Kumar Ravi,
> Qualcomm Innovation Center, Inc.

