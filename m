Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642B1CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D5C10FD10;
	Wed, 14 Oct 2026 12:28:36 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC1210FD10
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 12:28:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bhpd71fFxtWzcTvRTkkUXezDwviTHvWge6OD+uPBmyBc5bvZmehpghG5Owct2a9UjF6FoeNYIezSy3hl4Bn61dEj0L6i7vcpknlEJYNApu0JAPjXXvxPOXOZY+C3JuTSmWJPFmjSczAfszX4TVB/JZ0k3UM05u8A9Gt4ZtKhZGejy1p7H0ATYhWe0lzVnRafuIibPDXSEHZzpJHPkzokDrlUvZX/ye6RJboZlr6bfCZlnnLig8OSU716sdemX2iqsES2wgl3JzgpznehRdOw9++RMcOork14D/CA5/ai09XPDB4ldCEbEJxa9bScZiFDX1a9aujM5w3xRUgCEjnIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1pg1AxKKYhFfFGDjVBXFHtpWUt2zaTbTJYbKrkJ170=;
 b=EwlgcHSIf3Q1FL2VrNl9588ZNaZB7tg57jpnaceI68vh+lESy1LIO9c4g6Qj/kpH/jbEQGCVz+8dbeWyzBIkGyvcPn7IExcUObUEYwlf+RK5aKu/GLtU13VnhxRMemy6xxRPjdEwOU/hVQbJmKCmI97uKrT+JsdQtUTILbdHLwle8XfTvY2oRawCx/WqTFX5RnH+uAryBVbAHTdXg2ZTfGLSZrbZMjmVKHADT4WNaYQqAUhuAr6Li+SyCrCSnXh5QP9gYWlnElCv42Au21xBllaSxonMGRyS7yJPI8z/83xfoOaW/V2wWOymVLk4gOXXb0WpCOoExDwfB/DAVCkFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1pg1AxKKYhFfFGDjVBXFHtpWUt2zaTbTJYbKrkJ170=;
 b=AWVsIqRV12T/0rN+xqUNoJQ4STOTZop+TdzA/Kpg/ayoQ9j3DXviTAGPZO7WwJYkmstJttzBSEqyB3vui36K2/NQ0xohhcWy/RAi6KJgR763wu/WfU8hgVdjdAFCegKe77iVQZgLETm2f4B+H5RyMyMYnrPyp+DmJxNu1Gv8RhQoSTwUmvwBl2RdZ+fjpVyRFRpPZonI4gWY0Hl+QB8oxyjwNGeHoL+jwWkwF6dMADQdYrgh1i4HkRFq+Crm0Fccbk0L3KpGgX2C9txcc2YF91DxcTAMKgyS8U6bi1PT9ldhrF31pqTvYPRtlQmYtNAL3Pn++FKYYIjeo02Z/tRqHA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Wed, 14 Oct
 2026 12:28:14 +0000
Received: from CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2]) by CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2%3]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 12:28:14 +0000
Message-ID: <68a658f2-ccf6-4af4-bbdb-0f8384802a40@nvidia.com>
Date: Wed, 14 Oct 2026 14:28:07 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2 4/4] selftests: net: add devmem RX and TX netdev
 unregister tests
To: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Wei <dw@davidwei.uk>, Pavel Begunkov <asml.silence@gmail.com>,
 Taehee Yoo <ap420073@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Paolo Abeni <pabeni@redhat.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>,
 Kaifeng Wang <kaifengw@google.com>
References: <20261012174300.2338784-1-almasrymina@google.com>
 <20261012174300.2338784-5-almasrymina@google.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20261012174300.2338784-5-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::14) To CH1PR12MB9647.namprd12.prod.outlook.com
 (2603:10b6:610:2b0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9647:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: f0783d26-b078-4e3f-7f07-08df29ee9dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|11063799006|4143699003|921020|18002099003|56012099006|22082099003|6133799003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: xWVeOmmEYX8Myt3jMgH7RLy9niDLy2tTzYiJbUTIIOv74Lqsd+ze+bM9OJOhGt1gug1y4zJKT9zah5AqbP4NgCrzZcmNYsqRwExAMWMTK0XHkP8EgUGXVLBCw4jOL7s5Oq2wYk7YRqdd3bADkt7maIOOLC2YzfcxJ5sy+06cSvvctoVCPbASry3NV8Yxjg4IPDnhrk8ZbU9HbYKk6qeBQcnrc5IZPpX0snKBITNY48kXJvirvoDoTgBHVHZWdLriXGwx5XZ1htMzEtgO3w2nlE3/jUL5vZ0xnM6dy8fBNOULsanQE0a054Z+Voyz9Qvkb7wRILYiu1374tO/2ra41azLdxbxw7eG/Uua/Cse8YrZT6tnzEZVDuSf0if+o/GkgDzm9cUTr5/OApZ1YYk9voJJmhR35kn+T9zNXQaTWwThTUzV/8L5I0qfVziY0oFA9GpFeiAt9z1qO1tR7r/Zn9iPZIdOMR1TDERTgzDgxeTq2UD4oWbk1/FRIOjXdI5/f9lntTZg4GRB3Q4Y/DWpXh8KoGdYPf7czkkEQO9qbKINH4ntSwoN+NSMyHl4Nvb/cVSvNNK3OQ60mS/XpkitNtw9m5sryAYb4qmV9x6GY+uePruL/Q3zUJP6XCunm6b/8LqgeI4vfgu1gCMUuv8lF54Ni3q8O9lVKW7+d+YzRcub3LAGsiLo8tnT4jnbGP+n1T8e9a7vMJCGxdVBAIt1/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH1PR12MB9647.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(11063799006)(4143699003)(921020)(18002099003)(56012099006)(22082099003)(6133799003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1NEVXM0bTBIRHZXcTBnZzVJaE1MMHJacitqcDhNNnZlTVlrQWc1MVc3VDhG?=
 =?utf-8?B?UnR1TUxRQWhKelZPYi81UStIb1hBUnM4WHRKZkVCcTU2TVIrY1FjQkNrRWpY?=
 =?utf-8?B?dGVNT09EQjc1RUk4NWVZdWZ3SnZwSEVuQjRQVTg4S2kvdkNZQW02Vk5vRUc3?=
 =?utf-8?B?dTQ4ZEM0ZTNOWGZPb1J0eEhxclp0TEU5d2hMc3BPMkwxZnQ2OFhiLzZLdWNR?=
 =?utf-8?B?cnVBcFZreUtaVkg1QURYKzVvYzRFUXo5TFZpcEljQnV3cVFHTURGWXBFWkVz?=
 =?utf-8?B?THNQQVBoT0VoY0kvUHUwOEMyTklpQ3RkbEU0V0JMVzg3NmtjM2RuSEFweWxG?=
 =?utf-8?B?b1Y0ZlRyUjg5MjY3UUUyNFI1QnRuSXFsbWZQUE9jQkdPQURNdjNaT3FBeUVq?=
 =?utf-8?B?TExaTUNDczNpVkdLdThsZllXRnpFbGMxUi8rZFhpSHRSQVVyTm11YlJ3clV6?=
 =?utf-8?B?NFloYi9JSGZVK0ZwWlh1eW5MSGxiTEc0Nk45THlINDBPS1B4eUpFOXlldDd5?=
 =?utf-8?B?c1dLVnQxRE9KZ013VzFrdzkxS0lld2kzZmg0dGxSeHpDWXNWZEk3SnhNQ29k?=
 =?utf-8?B?VnZuVVdHelhNTlJuZ1BidmJEaUNHeUZSSCtmWDFBaEU0NmRtS1FIbWZ3TE1l?=
 =?utf-8?B?TFIrRVVvbDNKV3RSK0x3NlZYUFZHUG5kZDNKVkxOSHlRNWVGM2xQci9NVXk0?=
 =?utf-8?B?OTZMRGxvbWpDbVNCNTc0ekZrZDFKdVg3UUNrbjl2YXR0T1BtdXNwNFA3cGsy?=
 =?utf-8?B?K3lZbmlEcEt5bHpyRmFKOUpzTmlnK21SQ2tEUlVGeXZ0MUJGNW1uZS9VZlV2?=
 =?utf-8?B?VXhWZjBHMktTWVE3VVo1QlhoR1FoMWwzcUsrVVlqUjNsWlJBTTRER3Q3ZjUy?=
 =?utf-8?B?OEM3MmJxM241eW1ZTWlOVUFOY2xWY0kzcGVUd2N3Qk16RjQ2MEZ5bnQ1K0hU?=
 =?utf-8?B?d3MySEIwMDFCSGVCc1p4SVhYdEJVUitWQ2xMSTFJK2JUT3dnWjFpdGdBZHlK?=
 =?utf-8?B?THYxU1NPekhmWUhlN1UxL3BKcXBlRGlJdGhyVDc1MWJMV0M1WHhOUnlWelJq?=
 =?utf-8?B?UCtFdUI2ZzRyajJ2NHpRaGdnRnB0NDJpczZNSWhWTjJFeFAyQXBVSG9TOStQ?=
 =?utf-8?B?NmlKRzJKTXA4VVFKSFBHcW1SUTBGcnBrWExRbFRkTkluNzVZL0N2M3h6ellN?=
 =?utf-8?B?Y0VmQ25ML0JkS29EaGZSUy94cndib08vWS9yNVZGampUa0hoeVBPZm9Hbitj?=
 =?utf-8?B?QThxMmRZR1N0aEZMUnltNTBqK0d0dHJOMjRIMWEwVmwvazFpR0FUNzMzOGs4?=
 =?utf-8?B?MmNmbVJ0a0NjSGMzL0VnNHlPRUY4dk9aTjFURkhEVEFMUS9OcHJvMHJGd2lz?=
 =?utf-8?B?OXgrbmtjQW9wOW5WUnlBSmpHbFQ1NUxNT1FveU5MOG5hek1nQWhTclZhNjdj?=
 =?utf-8?B?UERQN0wyaGtkTng4VURKeUpvRVlrR1NNTkZnL1dWN0JNNTRvNHZicjFXemF3?=
 =?utf-8?B?MnJ0SDlTR3lPVWZGYWdmU2JNL2JXaTlzUmlOWUVpTXdza3h6eXRSMUVQenEw?=
 =?utf-8?B?bHRVQy9ldzhHMTNEMXE5VGVHdmdIQTIrcC9ZUGoxeTRqM2J6UzF2YnNXQWkx?=
 =?utf-8?B?UmVIdDgvOW0zWlFTZ2p6a3BqMmVOemd6bTRydG5nT3ZJL3kyU0c5bUowdGpG?=
 =?utf-8?B?QWo5VFJ0MzRWUm9jR2c0YWY1VENSK1g0WFUycnByd3FZZnJtRnhCOWR5RkNW?=
 =?utf-8?B?K09uWEt1TWp1bURxY1NDSGs2c2l5eXRKWE1rRFIrRllmb1BldVh0NUlxQ3dj?=
 =?utf-8?B?SFpRT3VUUyt6WXNPZ2ZoK01ENnRqSlVEcjR1ZHdHY29PMDJJMGJYOWZMc2FQ?=
 =?utf-8?B?ai9vVFlwMW4vMlhUTndGNDEzZ0VqM3dDNUdBMC9rSy82UTNkYkFzc0MzMnZi?=
 =?utf-8?B?ZHI0Sjk1YWpPeXpMV0J5NUNHaTR0U2hUcFF0Z3laelBSTkJIcUh1OXloN05Z?=
 =?utf-8?B?cEQrbUdvSkpTWDRTWVE1amxEa1NUVnRaZnMvdlhRNU00WGFmTlV5Z3kwakFP?=
 =?utf-8?B?elBtbVM2UENzMDFhVzZrSzBKM29SN2hJZ05CcG5JcWpQYTZzL2FUMUpjT3F5?=
 =?utf-8?B?UzBBUWgrWnA0eUhIbW9xR0lZMUFjUGxmaVFyMkZqYS9MUjJpalBzMEpzTHgy?=
 =?utf-8?B?S3NXZ0hvRnFSRTRiNmh0V1Z1SGsrcyt0dEtRY3c2NWoxMDg5RzEvR25Od3Nk?=
 =?utf-8?B?b3lnMXhKRjBWYW92bHN6S3RHbFZFRGtUSENZcHhPTmYvOFBkcldXejBVODY3?=
 =?utf-8?B?a1d2c29RZzFETXVuUHREWjZ3S3BNemJ4aHVicUppUXpmNVJXSlJxQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0783d26-b078-4e3f-7f07-08df29ee9dee
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9647.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:28:14.1046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2aYd3Ty47alJPew0cR4UmIhsCR7lAywJBrw8SOEB5o4P6+aOQ635L8PbOe2udLkwgezSY1NVD+jpRFi6i1Ufw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456
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



On 12.10.26 19:43, Mina Almasry wrote:
> Add devmem_bind_rx_unregister_check and devmem_bind_tx_unregister_check
> to nl_netdev.py to verify that unregistering a netdevsim device while a
> netlink socket holds an active RX or TX devmem binding synchronously
> detaches the dma_buf attachment and cleanly closes the netlink socket
> without use-after-free or page faults.
> 
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Kaifeng Wang <kaifengw@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  tools/testing/selftests/net/nl_netdev.py | 108 ++++++++++++++++++++++-
>  1 file changed, 105 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
> index ceb44c8e1fec5..bad230ee9dcd2 100755
> --- a/tools/testing/selftests/net/nl_netdev.py
> +++ b/tools/testing/selftests/net/nl_netdev.py
> @@ -6,10 +6,14 @@ Tests for the netdev netlink family.
>  """
>  
>  import errno
> +import fcntl
> +import mmap
> +import os
> +import struct
>  from os import system
> -from lib.py import ksft_run, ksft_exit
> +from lib.py import ksft_run, ksft_exit, KsftSkipEx
>  from lib.py import ksft_eq, ksft_ge, ksft_ne, ksft_raises, ksft_busy_wait
> -from lib.py import NetdevFamily, NetdevSimDev, NlError, defer, ip
> +from lib.py import EthtoolFamily, NetdevFamily, NetdevSimDev, NlError, defer, ip
>  
>  
>  def empty_check(nf) -> None:
> @@ -366,6 +370,102 @@ def page_pool_stats_ifindex_check(nf) -> None:
>      ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.info.id')
>  
>  
> +def _create_udmabuf(num_pages=64) -> int:
> +    """Create a sealed memfd-backed udmabuf fd for devmem tests."""
> +    if not os.path.exists("/dev/udmabuf"):
> +        raise KsftSkipEx("/dev/udmabuf is not available")
> +
> +    size = num_pages * mmap.PAGESIZE
> +    memfd = os.memfd_create("devmem-ksft", os.MFD_ALLOW_SEALING)
> +    os.ftruncate(memfd, size)
> +    fcntl.fcntl(memfd, 1033, 0x0002)  # F_ADD_SEALS, F_SEAL_SHRINK
> +    devfd = os.open("/dev/udmabuf", os.O_RDWR)
> +    req = bytearray(struct.pack("IIQQ", memfd, 0, 0, size))
> +    dmabuf_fd = fcntl.ioctl(devfd, 0x40187542, req)  # UDMABUF_CREATE
Nit: this could be a constant

> +    os.close(devfd)
> +    os.close(memfd)
> +    return dmabuf_fd
> +
> +
> +def _dmabuf_attached_devs():
> +    """Return attached device names from debugfs dma_buf/bufinfo if available."""
> +    path = "/sys/kernel/debug/dma_buf/bufinfo"
> +    if not os.path.exists(path):
> +        return None
> +    with open(path, "r", encoding="utf-8") as f:
> +        text = f.read()
> +    attached = []
> +    in_attached = False
> +    for line in text.splitlines():
> +        if line.strip() == "Attached Devices:":
> +            in_attached = True
> +            continue
> +        if in_attached:
> +            if line.startswith("\t") and line.strip():
> +                attached.append(line.strip())
> +            else:
> +                in_attached = False
> +    return attached
> +
> +
> +def devmem_bind_rx_unregister_check(_nf) -> None:
> +    """Verify RX devmem bindings detach dma_buf synchronously on netdev unregister."""
> +    dmabuf_fd = _create_udmabuf()
> +    nf_priv = NetdevFamily()
> +    ef = EthtoolFamily()
> +    nsimdev = NetdevSimDev(queue_count=2)
> +    nsim = nsimdev.nsims[0]
> +
> +    ip(f"link set dev {nsim.ifname} up")
> +    ef.rings_set({"header": {"dev-index": nsim.ifindex},
> +                  "tcp-data-split": "enabled"})
> +    nf_priv.bind_rx({
> +        "ifindex": nsim.ifindex,
> +        "fd": dmabuf_fd,
> +        "queues": [{"id": 1, "type": "rx"}],
> +    })
> +
> +    attached = _dmabuf_attached_devs()
> +    if attached is not None:
> +        ksft_ge(len(attached), 1)
> +
> +    nsimdev.remove()
> +
> +    attached = _dmabuf_attached_devs()
> +    if attached is not None:
> +        ksft_eq(len(attached), 0)
> +
> +    del nf_priv
> +    os.close(dmabuf_fd)
> +
> +
> +def devmem_bind_tx_unregister_check(_nf) -> None:
> +    """Verify TX devmem bindings detach cleanly on netdev unregister without UAF."""
> +    dmabuf_fd = _create_udmabuf()
> +    nf_priv = NetdevFamily()
> +    nsimdev = NetdevSimDev(queue_count=2)
> +    nsim = nsimdev.nsims[0]
> +
> +    ip(f"link set dev {nsim.ifname} up")
> +    nf_priv.bind_tx({
> +        "ifindex": nsim.ifindex,
> +        "fd": dmabuf_fd,
> +    })
> +
> +    attached = _dmabuf_attached_devs()
> +    if attached is not None:
> +        ksft_ge(len(attached), 1)
> +
> +    nsimdev.remove()
> +
> +    attached = _dmabuf_attached_devs()
> +    if attached is not None:
> +        ksft_eq(len(attached), 0)
> +
> +    del nf_priv
> +    os.close(dmabuf_fd)
> +
> +
>  def main() -> None:
>      """ Ksft boiler plate main """
>      nf = NetdevFamily()
> @@ -379,7 +479,9 @@ def main() -> None:
>                page_pool_check,
>                page_pool_dump_ifindex,
>                page_pool_ifindex_leak_check,
> -              page_pool_stats_ifindex_check
> +              page_pool_stats_ifindex_check,
> +              devmem_bind_rx_unregister_check,
> +              devmem_bind_tx_unregister_check
>                ],
>               args=(nf, ))
>      ksft_exit()

Other than the above nit:
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks,
Dragos

