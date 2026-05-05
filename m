Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149B4FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 12:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672E110E156;
	Tue,  5 May 2026 12:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jq4ewZIJ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD4810E156
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 12:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2sWncc+qjSmSndJLs9LeGir31sSjzTGGsUVIC+GJIInM0KDOSMAY4pTWqLasdKh9U/BRD2wvulBeYgd3wWn8kY5pLN2PndAixk2nqTJSmIpT/Q/zhFzK0wzGs2pxFn6PjJ8+i/blE3754TwumcCGj8l/97uOiWIanLVVtPAxxbU5oBDu2yx1hte+j1d9AOFLHeLX0d1APgwUxBMef1sGttv3d1E2vyO9uoZPPZE2AJHJmQuSM4MBn2Lcy4YWUNuzzGubZJEnkPPHm2j4aslRCgfkdJjru3NO3IxYNW0g1kRI112VPNLT2+9As/9f75dmRsVPvrDwwGYGQqs1BMKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFKc3hWKUvnQdqB/j6LYqQuZOaG3+PLE3eFLDcqI4Iw=;
 b=BelMLYddRDWf7xOcjUkL5k65Swoe0Jeob/ipG8P3qLmXe37c8ZvD0rP7J/46z3Rvj6Z+IcxRSbZ+vuSjOd7G0Qj1le9ztzLWyPPl8hvzszE0gV0G3itUQhUQa7L8MfNy4fsaC0MEyEd1fob0gFEqV3eh9lnAa7ns6iSbFy0H4+fTqLkQb4lFwq+RZcxO+V1R5q+/pRzy8kdaxsh7BgnLIOwvuJzZeKyIvOzjJgMMx81x+azEXBwEUnIrUhv1YwaRyAVfdLg8zJO0ApwxKihY8qFEw2YKOvA93fkSSysKTY9XBG2HwxvbQxB3G/1UH+zb98WKtf2cjMzsycLYq6KBlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFKc3hWKUvnQdqB/j6LYqQuZOaG3+PLE3eFLDcqI4Iw=;
 b=jq4ewZIJDf3tz0so2DNwExh4Inf9CnxTrIqKHHQ09mQGeMdIeMmk5L6ykFg+NN2z/M5Zz0aKnOPchLeTnjDr6oQRQlGvnbLMIvFWXZBgyVdicj1KpzESc9XPcco1bnafxAPer1QF6UQHPqdyHWvd3L0MfsV46vKLBzxmNMwG3vA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 12:41:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 12:41:44 +0000
Message-ID: <cf945dda-f526-4544-bc43-22f70acb28f5@amd.com>
Date: Tue, 5 May 2026 14:41:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Regression due to /sys/kernel/dmabuf/buffers removal
To: Julian Orth <ju.orth@gmail.com>, "T.J. Mercier" <tjmercier@google.com>
Cc: corbet@lwn.net, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>
References: <CAHijbEXhuVRgkkPA2dAC=njGBU7vpAbxAbsSmxvvPznO-ckVRA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAHijbEXhuVRgkkPA2dAC=njGBU7vpAbxAbsSmxvvPznO-ckVRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0332.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ea815e-83ee-4c26-bb98-08deaaa3a9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: DDonhNSOWFVbCAbHKi6hrE8mpMn1MQ9m+hc0OUNRgAV0oxpeGhxubbalDsLObbDFPUsvi2z5thxnbHjwYl1Cs5QisA8mcXR/qoZ85YS2DDj7PTnOdi4ioE8vCc44h4z0qokmmyij0M7n+iLddNNneHchz8q0hM5MCHDmk6apQgWM+O8Oz4ui9RiwXmY2a+EyHuO5YcSjezeT01ppKc/OOROVklY3JyjcVKS8MtsXXwCouz7vV3eD7DL6TWLohOfDS92yheO0DKIVQJEf+X8MN4HQrrSlj3sH9uAOIZX8dxGE5L+VIexjsarOAG32WhUPVp+i61S8hDOAru3vo+wzuJ/l3JlUt3ve9mdTIVaVeGGFfhUp3hk3e/AISIcL7oA2B4CsyjLKWt0NQznpRFxpKIaTblw4ecnLp525dlrhnTSxj25c3chwfWUVDA4yuJZjs+z7R1dRq9jZP1X04dqVpdszqLL3bJg1uVBNZy6q0pck+l01e2UPWFPaWB66UG1m6wcpwzYp8ueFXxjDKPXRsq11io0SjuuU7MB2vx3Frd8Nv4iExy1AvphpgcPwSJI34nOiq5rXHCmvFQpYUkGU+f5IU3MQNPpcWY3V9BfvoOVYclRtT7PO66bSd2RwzOKySSPX37l/w1QxndYLMPudDQlhIRSxzLzDT6wZGsKBNV6r+Fe9GrO579nyLuCeB/RV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG9iTkJLWEtWZStneGNrV2kySWtNcFNIRmtMVEdaYTB2LzYvbzlXSml3THlH?=
 =?utf-8?B?eUI1d2Jaa3RBYkR4ejNYRG5LeEcxcFFSNTNzc3E1cU1NbVF6N2NDK09CcXg2?=
 =?utf-8?B?TWFhaDJjSm9FTXJ5d3RpdFd6MFRjbnYyVFNnOWtPVVJ6eTBuczZySVM1QWZM?=
 =?utf-8?B?V0YxQVdpTENjOElJUUtUSUd1bnFUamRmL25LcjltbHh3dnpDUkMwZjZmazNW?=
 =?utf-8?B?VjVZNzR6cEpLR2xWWGpXREtSRUNDb1BTZURPSWpDRXNsZU5NNjcvL2psNFVk?=
 =?utf-8?B?N3QzWFE4N1pObmhqVWFhK3l6VEE3eStZMTB2WUFOQm9tQitiNnpBaVhtazlY?=
 =?utf-8?B?bW4wYjZkZzUxS2Q0b1VSRnVRWERhaEU1dWp0blJiMlRsN2hEU2RqbzZsTXUz?=
 =?utf-8?B?aUQzM2J5YVlOTlYwRE9GVFdDeDZLak5mTUNWekxSU1BjcGN3bG1LOVF0SkhP?=
 =?utf-8?B?ekJPNnBTbmhSRGdGZkpnTDd0d01Fbml5S216RktWdGs0S1hpbjlpdmFQVTJD?=
 =?utf-8?B?bWUrcUZOcEQvYnpmemczYVFyOWRmZk9pME1WTVdZR0VDSFZOK1pEeUNMV2dq?=
 =?utf-8?B?TENGTnBDN0ZjUTJ1b1o0RXBHVWVDdTF1M0g2UW5WY3hrVmVzU2ViVzQxeWhZ?=
 =?utf-8?B?WEkwczgranNoK2JMbE9RYTExTVZxSkR5QjFLQk5BK0x2dkZXTlpTRnc4cWlV?=
 =?utf-8?B?b1hGNTlHSFB0NmtuWXdDZ1hWRnNJSjJsNDEzSm5GdmkwbFIrbTJwZ0k3VHUz?=
 =?utf-8?B?MVQvZE1XYXZmVVZDanJxc3JxR3VBcWpUWWdER1ZZT3pFL0hjd2FCQ0prOTJv?=
 =?utf-8?B?SzNWenc2QnMrd3IranlxSmdtOFdoMUJFZC8xdERlYndpOGRJNFJtenFPV2FQ?=
 =?utf-8?B?Y00vaTNJeDVmcGtNZmxlYjNEdmV0N3BRbW8rV3RzYm5ZSmdmQVFuZUF4S0N2?=
 =?utf-8?B?a2pLdnE0MHFQY0lCKzlnYmE5dFZ3UHBiekVkTnVrUUtiYXF5ZWNKRWdqSFA0?=
 =?utf-8?B?cTRpMnBjZ1ByREkxRW00SWpHNnVJVWlmU1g0bWJCS2hoR3J0Vlp3UnVXb2hz?=
 =?utf-8?B?bHArZWQwZkFJUGRZcUZWSkJVVWhyZTZMWHh1aS9ZN2hrU2N2STNBaGhmOFh0?=
 =?utf-8?B?cXFmZTM2c3NqVmFnRDJvbHgzOUFCK2NKZ0U4Q2NZRHdPZGZCT1pTQWRGcUhs?=
 =?utf-8?B?UWJwWGI2dEd1YWlWVlAyWGE1aGJaU0lYcnF5cUxqbXhlOEFEUnBLMWhTYUlB?=
 =?utf-8?B?V2JHb3ZsQ1NhNjdNNUN4S2VhNytScFNhWXZMZHYrZzgwZXE1S0E1UGRJdlhs?=
 =?utf-8?B?K2o3b2YyYnE4ck42a0x5K0FrQ2dIb2NGaUovUlpXa29KTEtSaFBTVjF1c1Vp?=
 =?utf-8?B?Qms2YllwWjZ2aWYrOE5kRjB3R0Z2bmtHVHgwZFhFMzZYN1ZpbWFTbVZNVWhW?=
 =?utf-8?B?eFZXQ0FSR3ZVa2xtUU0xMmhrbzRZVmhBQ1BTQXRBdmZrMDFJcFZlU2k2ZVJU?=
 =?utf-8?B?NHgveXVKaHdGR3Z3SndtZW4rWS9rc20xNC9vK0pRZ1ZDcmdZbTFJQS9pYzN6?=
 =?utf-8?B?MWpVTmp0bmplQ2dXeExZSitKS2ZhcWMvRXkzUWFmbHB1NklqZlloZ0N5ZEJm?=
 =?utf-8?B?Um1PQ0V6Q2xZWktGbGYyRFROWWYwODZLL2VxbjBmVW4yYTA4dHp1WEIyb0JQ?=
 =?utf-8?B?RmNiUE5uZ1dwZ1M3ODE5K1RJN0Z4dzFNUnBxQlg2Zkp5VmdoVWxjdy9lcnB5?=
 =?utf-8?B?SUh5K0RHeHE0M2QzcFM1YTdVRTFFL3JDRFRyL1lXWHBYWVNTMitzVmg1WnV4?=
 =?utf-8?B?TmViSWpxdmhlaVFVUHByUXAyOXl1UzBncHpYMURWa0lGOGoySlFhS3F4Z1h5?=
 =?utf-8?B?OWZ6ZjF3ZS9zL3lUZGU3V1UrTC91SXkrNU1tUmxMa0hDOFYxUkJDZFBKb0VY?=
 =?utf-8?B?TnhYUzRyY1cyaGtCbWlQT09rSjZVZ1NWY21OWGNXUTM3WUxLTmd5WENqTGY3?=
 =?utf-8?B?bWNaZnE3TXozVEtWbEp6Q3p1YlFEejZhZUJhNE1DeVhCK1BCeU8ycGRNWUp2?=
 =?utf-8?B?cWh6VTVlREdBNTRWSGE5SE9CY2ZCQjNwbGJjTEtUMnNweG5NdnA2Y2g3THFJ?=
 =?utf-8?B?Uk01cGlSTDdMV0NLZ09YQlpWRTdLRFJCSFBmWmU1NmZFcFRUMDU2aityMTNo?=
 =?utf-8?B?NHNUVnlqT1B2Y1JwbGwrTWd1NHlLL04vOEltNEs1S2d1NVlVeXVIVVF4MEpa?=
 =?utf-8?B?b1pkcjdtTFZKeWhjM3BBckU0cFc1YnYzWDhNdXR1REFPT1NhU3d2R295Zjl1?=
 =?utf-8?Q?gEayx+IY8upJQIwFmD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ea815e-83ee-4c26-bb98-08deaaa3a9f4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 12:41:44.3668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9RKJE8j8z8PDl7XhZnTG1brmyqtxwT7dmRfuzqhYrJk29wBwDXyaPVj/F3Tt2l+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
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

Hi Julian,

On 5/5/26 14:25, Julian Orth wrote:
> In ab4c3dcf9a71582503b4fb25aeab884c696cab25 ("dma-buf: Remove DMA-BUF
> sysfs stats") the /sys/kernel/dmabuf/buffer directory was removed.
> 
> I've been using this interface, specifically the exporter_name file,
> to detect dmabufs created via udmabuf. Such dmabufs show "udmabuf" in
> exporter_name. I've been doing this for two reasons: 1) to detect that
> mmap on such buffers will be fast and 2) to detect that GPU access to
> such buffers will be slow.

Crap, I really hoped that Android was the only user of that sysfs interface since that approach turned out to be quite broken.

It's number one rule on Linux that we don't break userspace. So I hope that you don't insist on bringing that interface back, but if you do I will just revert the removal until we found a better solution.

> With the removal of that file, that detection mechanism no longer works.
> 
> I'm not particularly fond of that mechanism but it was the only one
> providing that functionality that I could find at the time. If there
> is another one, ideally an ioctl on the dmabuf, please let me know.

The virtual fdinfo file you can find under /proc/$pid/fdinfo/$fd also contains the exporter name for the DMA-buf.

You can find the full documentation here: https://docs.kernel.org/filesystems/proc.html#dma-buffer-files

Is that sufficient?

Additional to that the debugfs for DMA-buf also contains that information and I'm open to the suggestion with the IOCTL.

Regards,
Christian.

> 
> Shipping an entire BPF compiler in my application, which the original
> patch suggests as the replacement, is not an option when the removed
> alternative was simply reading a file.
> 
> Thanks, Julian

