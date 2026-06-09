Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01E5CD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C960E10E182;
	Tue,  9 Jun 2026 08:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="huZn8ZWL";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013058.outbound.protection.outlook.com
 [40.93.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7702810E182
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWUqJjk0EbCxCeRUjMgj5T4JSunda+1xgKpEhLikYDAXfP7YFViQVThpJPh8L0TrO4xtNvfEm0CL6qIzOzxDJAvLok6VRWmrttNouUfa1VUNYmqqA10c0IrYdsEFPP/YXDSvtdc5yzjiIUJ2HWCkEZvISYY75QiqbF3cA02dQ6nOm6x5HosIZPqssMpJwzHj19GmlrXtRKT3oB8cVJgCxAJJ3WeapGlDp84l8Di/yHoAFTi2eHCFcQFrFrRiD0m5v4Ug4oZvIHHU4DU+Ha4feDfMh/rj+zbbEp6nhPvLwJVsi0WJXINttn67INv0/I6DFCgK5eeRoNe0WGAVW0Acww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdDMJfjkaU6uecOhz/IO2eNYyUBEs9nN0DfthRmM5Uw=;
 b=vIMwWPY9UPUxdZE+d4+RjBTIBj/dgrMVh7IJO+7Cu+S4wrQsGUNtUnGIj4Xf6WQbEfj5lL1bOZ9RuSK8xXZe5Aay8Ij/wd++Qw/SK2okgqQJauaPhb+MJHMKbkCLX0QJyddArRWV2cTeUIQIuvtgTI3rLFmhOH3KdSFu57LYrHziwOz1xJFYAMTnCq0JhQpDmaUM6qY706cMLfGKTybMGwNLySZHEIA4ZIJStDJW+A+6BMNaVHS9IWEBkQyXyfwl8QkkIq+WKg0bihsOzz8tbOyzOg0Xx8TdjswfG8UfnwCKuLQDx1WwP2A+J54YUPINT4B9yyT5NCRrYaL4aXXgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdDMJfjkaU6uecOhz/IO2eNYyUBEs9nN0DfthRmM5Uw=;
 b=huZn8ZWLhGCfAoQMIPPUTb2uFGPhzRJ3Q0X/AB98Up+UD5qRWH92iaeyQRklNiA4RCRXSeCAKDLLPo5OtakO9SvZz0np09F39U9pLcY4Al4nNBqTG2OLi1N5TPmr+wOqzYXMK4FhYl/chpIu9NhSWU7hSth3qt/QLtt3drC0jhRNqq2rWyD56IMj7qAjeuT59SXn2RVGvKWPAm9xwJDYtzFyM5omvlpM3gkTRglvXyDGM9EjoK7ExvvPcrK4/IkD4RfkIqpoeR2pRj5+iZXIMJPxN7urZWq9MbWVaVNkOQczub6J8wTAmT3wdDgHWBCpHc50adPeKR45sNajnFI9zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 08:10:20 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 08:10:19 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 09 Jun 2026 17:09:20 +0900
Subject: [PATCH 4/6] gpu: host1x: Avoid stack over-read in debug output helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-b4-host1x-small-fixes-a-v1-4-7c1131c0b3ad@nvidia.com>
References: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
In-Reply-To: <20260609-b4-host1x-small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OSTP286CA0067.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:226::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfc3b33-37db-41b7-c8ca-08dec5fe8bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ErFhNc9FHuZndZQJ1OT5CKaz3dUkFS+FGzPRiTeB7YD6GTkj7Nx8iUhT55QkRIXaW3+yaOfL+D2iXIKRmATpGK8oSRxNwWD8YO2sVMwXemv/HrqCIDDHCqe/qSBy80xhsKTh9pORlS8kzWQPyCyr8E2f6HmxpcqivlylCli2olocude2a7ifcAvsqMm0BtpNT3fdXc+sLinrSYhf1j+3UCCROOGn6x3UrVjeIo6rU5EhvX0xtQ+QUSWddmsV0gsryyCNP4JUQ5CU35W4kiHoVofcdRzKWX5uNtOdM/BSrXLwed8dt7atOuyudsbmcYZL5xgZYM7N8XtCXdpIrRnomKIFYd7v/aCxannvd8PeIRf1NoOkRB+ZqpNkex0dJglF0vs3B7rkIa5wBp2eLYjnO5IsV+/XiBZQnuS6hZ66U8K/9cpmK8sy+vGGadvzZTVdQT8SP3DfLwsjyNfSPqxdayT82B4FySdELigR1jmGnRUTkkG9Y6EUGTiD5J/eo9Zfh9RNf4N02To7+EWqt7GvGnj5LEdgdcplI+zzKrTUzqCthNorixOvxQNC2rnt4G5SZ41t/LWIvG1YiFSu9IjtTRUgiDArxn4qnxVlzugekUrQqfJ0Z/w1v3GkD581gC8sXuAZpT4Vc8wABdys74qunsIQV/zYMWQdYBcbUYgFx3lLQFjoVMWidA7jepbnIeYy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2FWaWVkUCtzQkN1a1lZUjlWTTlwVmJHL0hWWEtNSWVFOE1qTnY4aTNSNnVt?=
 =?utf-8?B?Zk9ZMEQ0Z2s5aEZ0UTRoN2w1WEpzdmlocjQxZm5LNGFqb0R2NWY1Q0JYMDBl?=
 =?utf-8?B?YnU3Ulk5d21FakM3QkJ4TlZqcHZPSE1CWW14bjlDZFlYaXFKOW10ZnQ4RC9a?=
 =?utf-8?B?MFlnN3RjVmZZWmgycE9VZzRZb0I3aG1FUWNJUjd5dDNSdE1BNTdsODlZNlJS?=
 =?utf-8?B?c1VGNkVtWi96Sk9HcnBwTVNub1B0STJ5NDJhcnp0S0tXaytjbW1MaFZZTGlO?=
 =?utf-8?B?WnNJcGxQUHlVdWp3aXY0SEdpejJtU0ZPV3lqQmJERTJYUndGeFZKRGw2d29T?=
 =?utf-8?B?bUxEamZOZTVVem44bTIycHE4Z2RXa2FqSjdiUHBKWFRXU0U3aDBoUFQ5UURN?=
 =?utf-8?B?TC9FT0ZYV2FRMnBSQUFiVU1RcTY3cngrVkk5dWdDai8yOXVRZ2UrK2t2Uit2?=
 =?utf-8?B?RVAyaGlQc2V6emlFNHc2bERER0dMS3RyOVFLdWVmR0ZkWmJLZVJ4L3BBcTNa?=
 =?utf-8?B?dlVBZThpYVlSVUp1dit4cDJiQzB6NGhVbTA1QnFtcGxaRWNwamlubDRSeTZY?=
 =?utf-8?B?dGRvMXN5NFRZRThEOHZzU2ZHV0t5RHlxUUpPQk1LalVtbVdBYk1oNjEzYytv?=
 =?utf-8?B?eld0eEEyUmRpakRlNXZxVkRweXY0M0paTFNHcFhlNHh0Wlp1aXV0ZUFxYjBN?=
 =?utf-8?B?RW1yR1NIbTdwb2ZlRXBLNjEraU1rY29OdlozQjZXYzBGZU1CbmtCcmhDTWRW?=
 =?utf-8?B?NmtwQWRSS3Q5andRMnRKN3NmajFpZndsb3phZFRoaW1yUG5HRTJyTGhaR0N5?=
 =?utf-8?B?d1R2RGJsMFliUDkxeWYxZ2pzMHVMMDBONmhhcVBqV3cyNnpGemlxYW94Znpa?=
 =?utf-8?B?Rm5Qd29vRDB2SmRZVUhFTTBua0s5SDNwNkhUc1pnZW5NaXgxM2RJZlRpMHB4?=
 =?utf-8?B?b0F0c0ZIY2FzZnprdTN1S2creVdCbElsZGlsVmxuQWNsM2RHTjJzdWF1RlV4?=
 =?utf-8?B?VmpRTFRlN1BDVjNxWG44Mm9LdmRITHZSUldJZnBxQTg5K3lqN2dNb1JwQkdO?=
 =?utf-8?B?dnN6b2RGK1FZQ1o4aGo0dFF2V0VnU1UwdXpsQWZqYTBzdDlTRkNuS2lVelI3?=
 =?utf-8?B?MmxUenpOdVR0TC8wbHdpdk1EMDA4VExNSTJPVHplZHBjb0NuaEdEK2RWK1ls?=
 =?utf-8?B?Y3BxaUNvUGJqd3hFalBpYjIzbkM0MHNwTWg5ZFB1ZTZZMmRrR3JIaVpxNWR1?=
 =?utf-8?B?U3pvQTc1TmZCckR4NitBNEVNK2p5SlAvRkcxNHNQSllQdysrM2NVdGpieldk?=
 =?utf-8?B?a1hxMlEvSFdRbU1BT1VWY1RZbW5PTHlqMlJvd1puMmdkR1FMMGx4bXpCck82?=
 =?utf-8?B?MmpkSGJZaC9raDFhanlHV04rbzlmclNHQXFnWTd3VEgxMG42ZCswR3JNOEVX?=
 =?utf-8?B?QmJaQnRNajZpcDNjd0pFWnNzcHpFOGNSYjR0YmdxMGMyc2QwSFc2UEx2VzU3?=
 =?utf-8?B?RENuaXNpeEtaTitueTFTUTUrZlhkN05xZmdHQ3R1d3RSemsrVDNsdVBUWG55?=
 =?utf-8?B?T0dOcWF0MGZOU2lMd2JacmhDNkUrajFBZGZGZmFUc1pGRmFENGxoVU8wQk1l?=
 =?utf-8?B?MjBUYzZFZUpKZkZsK2ErUk5PYUVYZXBhN0RtbVg2TjVMdkRza1VOMlhIZmJ3?=
 =?utf-8?B?R2hVZ2IvdTRxVjhLZDhxQkV2RCtManhoYjU1V21HWjArek1ZVmgza2Irbkgz?=
 =?utf-8?B?ZTNnblhWSHdhbDdBMkV6L2l2RWcxLyt1WVRaWTFkU1RGbnRiQnZzeWEwSzFI?=
 =?utf-8?B?WDNHT05QTmt5bVBqODJDaDlSdTdITDl4b2o0WXNjdnNUajRHTzNiWGcrZUVV?=
 =?utf-8?B?Vkk5NEZaTG9aTXVDdWwrdWN2MC9xZlIwZU02b0JrQ2FmTU9BRnhBSFYwQ2Er?=
 =?utf-8?B?WksyMTJFNUFoRWxtUXRCMlhYMmZXYTZmVi9lWW5ienVnV1R1QlpQMjdjc1RF?=
 =?utf-8?B?ck1LLzhHcnBNMndJVTgzdEpqbzVrc0xFTDliM2ZKNXFuTGNVK1RGeEVLOTFS?=
 =?utf-8?B?TUx6bUpVdlNCMHRRTk1kTVNveGx4V2ZsQ0lWUXpWRFpuOEpNenhNWDF2NWhY?=
 =?utf-8?B?MENVWi9HOHpqbkhVODduV1ZKWGtITDdCdVpPdyttdFdTNE5wL1p2aEt0dEov?=
 =?utf-8?B?TlBsdWxGaWhiNlR2R0srRlhDVndUaUVwZnNrRC9hWWJBSDlhQWNjOVBydXJ6?=
 =?utf-8?B?YzZsR0hFMDR3a2VxdGRVQVV6aUZDK0NxN3FwbTRUbytPemNIUkVOMVpJNWd1?=
 =?utf-8?B?VFhDTmxYcXVBcGJlSFRyRUJHRU5QaHBBckZ3YVJXRFMvYnpVbWYzQmxhUXUr?=
 =?utf-8?Q?jR677fu1bzecVKM3BOKZ211sJJ4x+rG0/azIgO74mbrPW?=
X-MS-Exchange-AntiSpam-MessageData-1: zvx5FEy3yuAwFA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfc3b33-37db-41b7-c8ca-08dec5fe8bcd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:10:19.1937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3ril78VHtOOdUgQ6mrCE9rcQ+xGbxXi/jC+k6at0LzZlIBfvajadxk6k8KUQA802VLCVKK4Bobu8baMRYxF3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900
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

host1x_debug_output() and host1x_debug_cont() used vsnprintf(), which
returns the length the formatted string would have reached with an
unbounded buffer. That return value was passed straight to o->fn as
the number of bytes to emit.

This could cause a read past end of the output buffer if a call to
host1x_debug_* produced a string longer than 256 bytes. This only
affected the debugfs files as the printk debug sink ignores the
number of bytes. In practice, this is very unlikely to occur.

Fix by switching to vscnprintf(), which returns the number of bytes
actually written.

Fixes: 6236451d83a7 ("gpu: host1x: Add debug support")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/debug.c b/drivers/gpu/host1x/debug.c
index 6433c00d5d7e..b828f773fc06 100644
--- a/drivers/gpu/host1x/debug.c
+++ b/drivers/gpu/host1x/debug.c
@@ -31,7 +31,7 @@ void host1x_debug_output(struct output *o, const char *fmt, ...)
 	int len;
 
 	va_start(args, fmt);
-	len = vsnprintf(o->buf, sizeof(o->buf), fmt, args);
+	len = vscnprintf(o->buf, sizeof(o->buf), fmt, args);
 	va_end(args);
 
 	o->fn(o->ctx, o->buf, len, false);
@@ -43,7 +43,7 @@ void host1x_debug_cont(struct output *o, const char *fmt, ...)
 	int len;
 
 	va_start(args, fmt);
-	len = vsnprintf(o->buf, sizeof(o->buf), fmt, args);
+	len = vscnprintf(o->buf, sizeof(o->buf), fmt, args);
 	va_end(args);
 
 	o->fn(o->ctx, o->buf, len, true);

-- 
2.53.0

