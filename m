Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F65ACD4F5E
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 11:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 390FE10E37C;
	Thu, 21 May 2026 11:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LY27d+5O";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012010.outbound.protection.outlook.com
 [40.93.195.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C76A010E37C
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESUhGOgw9P5aA4gqvelhOxOMb24ZnlZmhGytOh/M/g0Tg9YtQjE50Twvqq94CxYZ3V1k97M8l4c7UyraOYGsvqRuXMxcYoOwouSIpPj6gv4mDV6DPvDaKR7GimBLS9zePeTAddJbiJLBPAaJ0o34zacHCyWSKqFNsx0ZmtUGrhJ/BNZW480YrMIBr2S+BZ/2rKSqihGeHILkXnM5mvBp5YUi1IRzlLOLAa4tRPuJRK2zdxzoRlhSGQUsUeiX/4c0FJvE33DElWgYxBkRinEPBSGpuKcrbe7eHTA1i9bXeLfUSHDYAYPDJejP62PQiv7N1tbpWGGd4SKX0hdY7Z9KbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWW4JyyFUstndBpWH8KJ5I49JIoYpkkYyXr01/82S2o=;
 b=Bw/VMnVngxS9zZrTGiNytEQLpcPdSL1OBjiv710m8/7omiZsh+0tK9EaLuCFPO+Zs47xmVrVMwr5So8zxoW8eh9kOIReEMXIwAYO6KSC5u9X0MQeArHkFW5Sz/vEHzrCpR8JuE4dRMC6kl+okW4f7rR4P2ToJWhtyRnv0hzfJ12FtHjn4TfUuKdqJhPR7YIjL6kWDcTqYuj3YaD7rhfd/U1FQ1pB9HZXLYAf9GqVAYMn8db2H9YL6v0R5UWtN3sQbihInXkbihbvRkCYF1BYsKhOGhMq8tGFp7oAT9fRshpz4cna13go3jLSm7f7OUkrHda7wsttEzUMIXyr9XuVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWW4JyyFUstndBpWH8KJ5I49JIoYpkkYyXr01/82S2o=;
 b=LY27d+5O45o9JX4aHju7zX0RNB2Gm0o0LNh/bYOqN2iW+5PiIBa1+wiQ9OMZqUwM6wlIgDYVD9Orht66LjmZkxotA7TsAuAYmGEEh6CWLIeMhB64oVta+bvdHid//utbQ5DbGNnL85rLpmCyatOHJQoNzUZys+P0G25aWBkDljdhdZBBoYMS1qhwtyUMqgrUOusq9WQuW1G+/gQDPJIp4vW2vFaKTpKP6btsB1gtc2PSSnR5/RpUl8TG27F+0ZLbf78S6BR6Ni9LH08QAByYQsbyr9gJvQLZrod5zdHWY8DKVZlBYxZARXiaWdZpQdCuhUpwlBqgX2NGyzmTA6K53g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:03:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 11:03:46 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 20:03:42 +0900
Message-Id: <DIOAZCL9W7F7.J3WV406BXTY8@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 7/7] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
 <20260515-nova-unload-v5-7-c4d6250ad160@nvidia.com>
 <DIMAVKJECLKH.UXLZASCKVJK0@nvidia.com>
In-Reply-To: <DIMAVKJECLKH.UXLZASCKVJK0@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0154.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1ff3ff-2cd5-4ba9-d4bb-08deb728a0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|56012099003|18002099003|22082099003|4143699003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: qN3PWlNQ3kLe2bMqSnONT2/pTT6vRo9IqLfhU63p9spCpqOCDs8uwdK0ptimi0lRw2f8/ACTdDUctZj/0O3frtOg5qvQiPsYNr8+LLZwXChZKFPxi8X+hB4BygK6TbW7lwQ2HDE6JpEw4BPvmqtQRsqZsZsTrXw41a4PXqEG7TR81MZ76VDV9H13qfZjGfaEDW/+Q5IJ6a3ZE17DKMSF6lrZ9uhBzdpa13kkf3rjht435//kzw+IE3c+rJtUDW4u4N6Jiaeq15PdlYxMRgSvnmIVKV9llhZ5UsL+bnkNl1hP+P5iGp/jJTtkprpZvPLS5eAheJLNN+gPjRgDLv1tFpxu+aZVyKFN2tG+HpaNl0MC+XIXF8pcFHUZOzg78JgNl1ApI97xT+gQdVfDI07Jkh4PlEZV3XUFv1NOEC1W8Zkxwc6BG2rCseFdnehoZUV5PRy14OcUfhT7DVpfj7OG2K5AznLTKktsVprqEIzEqz6V1Itq+Vda6cxsRm+loe9RTqNDgAq9kM8gOFvXlq57kdLk0nn3Sa409C6HD7XGKEopOcCM63lrwH9+ySJBKfiWlxWK6OMLfsROu08jZGRI0wrQC9W8r4e62YZk7r8Jq/tgtRl4uMkVKHLxGS4A/UGvwIVw5DZStEZq4ohTklTGyActzrYbfqRYYPCfGTDMG68XAAG3Tz0GaAFhMLfAzWfh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003)(4143699003)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXlIYXlNdFVncFRJbzVxb2EyVU1sUTIrM2Q4MEZhREZQWlFtV2gvRkxtSG8r?=
 =?utf-8?B?TTBIV1d6dlJGU0oybW1KaGRGK1BFQ0U0MVo0YTBGMWYwbllkNW9iUVhlNUtv?=
 =?utf-8?B?ODc0WVR3RkVrUXYyS0ZKajAwOGpXOXRuakd3K1BMdElCcFp5Z255ZFB5Ymt6?=
 =?utf-8?B?REoxeUtPdDlEY2c3T1NJWVVTYlFiTEIvcTRPSlBwNjVPaVphMWZrTUFVcGhk?=
 =?utf-8?B?TU9lK25tUEtWK0VkVHVEZGt0dUdlbjlKV3Zla0U3dFBnK2Rxc3RKRWViVmp4?=
 =?utf-8?B?VzkwL29BaVptQVV0UjlFNEpMajIzWkQ3aUFNT1JmTW5jRTE2dTRnaVFnUU5L?=
 =?utf-8?B?L3V1aWRCVVFiWGdMQlhNaC9hVXlYdWN2empSeTZTUzQ5VVZKay8vN1l3dksy?=
 =?utf-8?B?OGRUZGlLYTkrZWphQjBzdXVTaWJxUGd2cGlIOFNDaVU3T1V1aEdwcCtkcy90?=
 =?utf-8?B?dUxESks2eENkYkxhZUhOOWxncTVhNHhSTUtCV0NIdnMwNTd3UGlFNWNBcmM5?=
 =?utf-8?B?ZkFmN2lZbzVZM3ZhaEZPQ1A0MFFVelYwR1RRSVJBYzhacUlNeXpNcUJvRXIz?=
 =?utf-8?B?T01FTjlXaTM2NDl0NWVXRUwxZlZVTDROR0I0UDNtZHRYUTE4STFxbkhEM1NG?=
 =?utf-8?B?aWIyNEZBS2tlU2dSK0c0aU5TTFdYQWNPa0hMT3lhYmVHei9FNkZOUW1TbHJY?=
 =?utf-8?B?T0EyQmJuaUVWS1FQRWlOMGJXd1JBb0pqSS9CTVRpZHNjVG5hdTFOK25POUc3?=
 =?utf-8?B?ZFYvYVE5a1Y0Z1p0WXdZK0Ezb0tGbFYzTHpuTlA4dkFzZW4wd0IxQzF0Nlpl?=
 =?utf-8?B?QWdua0pJcXM2QTR2ZUw2alowRmY3VGtYWkxRcTRjcEZNZUhkc1pFaFhyZzZo?=
 =?utf-8?B?dmkxUldKKzZFa2lXMksyVVhhRmdHUUhnMUpob1Nhb08zR2RUMy8vTXhHVEY3?=
 =?utf-8?B?ZTVQelc0bkp2VjZWM0FnbVpYTXVUa2NwS01sSXZtS254RjNkNVpKM1dvenA2?=
 =?utf-8?B?eFlObFRCK3p4MVFjY0VITVRqbytzeWJyVldiS3dTWnZ0dkpidmhFT282TC9K?=
 =?utf-8?B?L09ub3o3QnpOSlVldFJrbFBaZnQyS3I4VzdxbHdGTHplcWpoL1daSEpwR2Fu?=
 =?utf-8?B?b0lwd3I2dklSWi8xaThFU0pnSkt6WWs0cXo4SnQwcVZkdUNsRGtKM1NpamRu?=
 =?utf-8?B?OG1FTENpNkM2VGhyRjVBSTZubGdvazRUWFNVdXE0dTd1MmdlWG9yeWlpU1Bi?=
 =?utf-8?B?b0Jya3JNd1lIQlNTU0RMY0VVMmhJY1BRakdvdk5heExnOExleUpxTVc2M3d2?=
 =?utf-8?B?MTl6YXJOU09abGs3M2lHcVJNVGdHb080MGRkNFpPVlIrclltYzZDMmk3TmRV?=
 =?utf-8?B?Z2c0alJlMDRoeXVVaW5ZTXdKK0M5Y1B3bHZ0SDFoajVNc29uZGZENWJxRU9B?=
 =?utf-8?B?am5XTFd5cjdOLzFObEdvZ3d0ZHlxRjVLSDAyMVc0UEZnem92WUNDb1RadDBa?=
 =?utf-8?B?clBWYUs3ejZraVpPU09hZFpNS2FCS3U0cFU4bDRHN0ZzNzY1MmNVRnZ1K1Vo?=
 =?utf-8?B?a1BINnZ2NnU3SFd0UUloVU9LRWdvZE0zZ3Q4bG9WRW1YVnVTZEl6UWJ4UFds?=
 =?utf-8?B?QzhiWXRHejc5ckdZeGdaWU1pQXREeGJzNDluQm10eE1nRThwSVExSnByUnJh?=
 =?utf-8?B?aUN0RC9BL0Z1UEZES1dpS1U3MFhZd3lldXp0SVp2VzdkeHo1eFlzRGhpZk8w?=
 =?utf-8?B?UGtyMG11ZG1DcjE1MzZ4VDFiZUlyNkpMdUxzZ3FvNGU1Mkd0NzlENFhhVHdD?=
 =?utf-8?B?N2RVR0pUTk1vdXVvV1JNcFZGTEJNSzIwbjlDRDhncWpQdEI5KzVVSWNOQzBV?=
 =?utf-8?B?WHFsejJtYk5xUURyRGxRZmh6dzY4Y1lkNExRQURienNFait1YjVlSVhuZ2Yy?=
 =?utf-8?B?eTRGdmFHTUh3alBzb3RyTXFjelNhYWRrdWxiQWpsQXkwT0FDRjkxOG9UZFVR?=
 =?utf-8?B?S1ZLTDdYcWxnR0t4d2J2cU5XU2ljWFJYTW4vZmxPWHNZY2ZyejNWNUNOWWtt?=
 =?utf-8?B?cnNXN2JtSHRIK0JmdFQ2WFcvV3hicXNoZUxaak05UUhnQXFid3pJdE8xd1E1?=
 =?utf-8?B?MERkTjdzdVM4MTZPd1JILzl3Rm9veU95VFlxSnQwcmxqRUtUUjAvWGNaekhk?=
 =?utf-8?B?OW9QYVAzNFZVdEdRN0p1ZmVSdWZOUjYydHZuRUdxOUt4TXBHUnBhWXVNMGQ4?=
 =?utf-8?B?ZlY5SHFXdkdUclI0ck9XV0xYRFZkb3ljamFKVitqeXRJVVl0YnBXbUNwS1ZU?=
 =?utf-8?B?N1k0ckJ0dU1zbVN2RHdkVW1QVDE4dlhEUjhPWFJobVJUUnhzRlV3dEIxODgx?=
 =?utf-8?Q?CV0Kz84K/VWnpnhoJLZUVAyg3P84m+MSplk4G002r0IIj?=
X-MS-Exchange-AntiSpam-MessageData-1: WSXm/JOHjVng+A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1ff3ff-2cd5-4ba9-d4bb-08deb728a0b8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:03:46.0395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcZPl+1hYQfR/5YyK5rMuRX3K2u/MQan5yPl4IBWOB5BhwG94sDiXRqwLelwyjoLcv0ImwjYyHvPYRf0rRBxJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314
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

Hi Eliot,

On Tue May 19, 2026 at 11:33 AM JST, Eliot Courtney wrote:
>> =20
>> +        // With the GSP shut down, reset the GSP so it can be restarted=
.
>> +        if let Some(unload_bundle) =3D self.unload.as_ref() {
>> +            unload_bundle.run(dev, bar, gsp_falcon, sec2_falcon)?;
>> +        } else {
>> +            dev_warn!(
>> +                dev,
>> +                "Unload bundle is missing, GSP won't be properly reset.=
\n"
>> +            );
>> +        }
>
> It feels a bit odd to me to (conceptually) allow the unload bundle to be
> run multiple times. IMO, ideally we would be able to take() this. Since
> we don't have a mut self though we can't unless we add a Mutex or
> something. If we do, we can update UnloadBundle::run to consume the
> value so it can only be run once, which is nice. WDYT?

I'm a bit on the fence. On the one hand yes, we typically want the
unload bundle to be run only once. On the other hand, we can also
imagine than `unload` fails for some reason (say, the GSP refused to
shut down when asked), and the driver decides to try again sometime
later. It's not what we do now, but doing so would technically not be
incorrect.

I would feel strongly about enforcing single-shot use if this had safety
implications, but here it is just to enforce something that is already
structurally guaranteed by the driver core and that, in the worst case,
returns a runtime error. IIUC `boot` has the same problem as well - it
can be called even after the GSP is booted, it would just fail pretty
early.

With that in mind, I am not sure it is worth introducing a `Mutex` just
for that. We could also use a `Cell` as of now, but since `Gsp` will
probably need to be `Sync` soon that also won't work too well.

But there is another option: store the `UnloadBundle` into `NovaCore`,
and make `NovaCoreDriver::unbind` pass it to `Gpu::unbind` and by
transition to Gsp::unload` as an argument. This would address the issue
partially, as now unloading can only be initiated by the driver. And
here we should be able to use `Cell` as `NovaCore` doesn't need to be
`Sync`, and implement single-shot logic without a `Mutex`.

The drawback being that this complicates `Gpu::new` a bit, as the unload
bundle would now need to be passed as a `& mut` reference to be written
to, i.e. an output argument which is not super idiomatic to do imho. But
I'll give it a try to see how it looks.

I've addressed all the other comments, thanks for the review!
