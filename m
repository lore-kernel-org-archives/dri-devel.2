Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460B606A32D
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d+0UMnEs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87BBB10E4CA;
	Sat,  7 Nov 2026 01:40:58 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010064.outbound.protection.outlook.com
 [52.101.193.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF62410E4CA
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 01:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMSy639wSBDJqGV5l2nOpMo50UYyyNmUOxrIQekj3lNWeWJToyujJIVrHf+oZsvUq9bPLRw6KWWRWE47FYdnBEcSQbp4eJrQCsLJIramJfq5pgkuFA/5Y0YtlUfYIKqDXZNl/gSIRD6zwXtAj3YtLK98r5t3Q5YiNC+a6uaFV3vEmwGgHnKY8mwQYiX+8SUzC+0WJWqyp3/IjfdoOuxpvV2w9UqlBfM4FYiC3u2UkrQIA+v+ShFrWqzFQfL6rlDK5gNyfMqvHkl1qm6gD5+5gKw1ZAFaZ+3FRCKgfq8prbURmAkdDqimzWc4XROBXJ1QO5VoYOzvQk0H/tj6d6/oLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqtksDYPX1icAauOmsVuGmYeKlfhNOImMDWv+zrPZXU=;
 b=lHDYur5usPWaaxdnyIdQKKfIxOBZ+EyYUtTBCxXjFNpRZzY4OqJRxOXASEPdZQ0dkGeMsZe010MpocB8kxlfZjGhSlUblXoT8JzCvGb4RhmGmF/mltmjXpBuwXQWtoBQC5v1MkdG2Tb3vjGklq7bW2XtxRnFIWK4tw9BHa8N1k8bbJK3GBUlxiMt/kS5lbY8YRVK5EmbLe00rtLEd9xgDlVYH1LaDVpmbFQDVR5afd9ntH9v4VIyZskv47oypitLPOf4aDBfhxSorUr0vPHwXxQW1jQjESbrMDiqMX8KVlC6sl1QkNSJajDcl/HGQJ4at4MlIdR/Kvj3KMePVNhiYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqtksDYPX1icAauOmsVuGmYeKlfhNOImMDWv+zrPZXU=;
 b=d+0UMnEsQxFRsa+KiMZ/tQdSikPPVZmeMi2VNnuIwXlgR3kf7piVM7L3rKEdqDpgxHvuXTuf4a/Ch5shAgpNb5t+0w032VNWHDs61Y0hz/57H8JyZ8+4MPx0v/fiRPeJsokI6oBlVC2qAFH4MR5Y/OEk6Dbr1OjjTHD6S30TONlS7LzOhUG2aYwNc2SHEqgsYO4DcFFdNoxlIlI6a2O9c4SWsyQI5vwvt3iYEih9Yz5VnhXgdaebsP8JUy1uU6aIz5lNxiYOBpEbFXW5wNw3lyo4FlIOqnQHR5tELzGKkYCEAF1+evvpmbxpTC3LujofYwzRucesdLAizyePRI0AAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by CHAPR12MB999225.namprd12.prod.outlook.com (2603:10b6:610:2fe::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 01:40:46 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0569.011; Sat, 7 Nov 2026
 01:40:46 +0000
Message-ID: <af634f12-02d9-483d-a17d-31d3f6024981@nvidia.com>
Date: Fri, 6 Nov 2026 17:40:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] gpu: nova-core: retain the GSP-RM log buffers
To: Danilo Krummrich <dakr@kernel.org>
Cc: Vladislav Zaharov <vladazaharova2018@gmail.com>, acourbot@nvidia.com,
 aliceryhl@google.com, ttabi@nvidia.com, gary@garyguo.net,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
 <ce4c6b64-98ff-4b50-8454-9cdb5aa6970e@nvidia.com>
 <DMOLFAB4UNSV.1A99UVEZAI527@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DMOLFAB4UNSV.1A99UVEZAI527@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|CHAPR12MB999225:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de0f6ed-11d7-48f7-dea7-08df3c7024b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|6133799003|10067099003|4143699003|56012099006|11063799006|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261022105027099003|261021121427099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: FCAdAz4BNNECyFYvI8tCl1c/UlbYmCXZLWu7Wi2smTXGiEq9/HaKjYRUFuPaFr6a8UKPbZAWhKHM+ETY0+D/qXU1q95rPsZJHPq9R3H0zFI95pla9txT+gVRMaVQqrvBVs6e/m+sz+oySN3VwJ52kbbouj3Cx4YmvR54unJBygrEwqeQ7G2EAxGTqh96IfH56oxdemp5fWaENz6QI6OThAYNDf0I07egURvXdJigcTctQo/1d+3Ojr9bt1sh11ypgMROLSKP4jnn0ZnBSrxlJxqTdRx59JZnYw02MHCBsI8PmZMhr/gvDfeVHVYkRaAeh2+8Xse9ZzfHaMsRKxgVnwbKNAmVJYKTk6SnHKyvyeoqsC4FJ2EzrwLTICD27DX5MbRl5/gr1H89fDDP10daU66KrWRlBRqW9uWUSgr3Xl1AQzRC/F4IkT9f+soCWwzpiW1Z8OXugxZ5vBa7TGFFgiBBcNshGB2ESOWejQL+r4qJ9Jdd4Nk18jUVHau1WnvuwYgIs7uUrV6yYhWvEYU535QQd2IrP2JCicxsIkTt1xSX3dXITSHL5hKXqoDZG5MX/WVmV3A4kKYrflUWHnfLtJx0qcjpNHliA2FOVkHNu6iXZPtEzNFR47k+1KRcWdSlS1wQFpUI3aynst0iMBnwAVK3DqYS7alXPwnN939YwXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261022105027099003)(261021121427099003)(261009223027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ni8yTUZLZFZaSEJxVytVUFdjdG8yMGoySFBMSVNCUUt0elRzSy9oUmZjY1Rq?=
 =?utf-8?B?eGM3R2xma1BZRG5MSU5aUElRRWxrWWErTmtPY2VWN2JTVWlzOEx3azlyL0U1?=
 =?utf-8?B?WXpjM1BJdmhiZ0RTd1JBZDJ3OFRiY3IxTG9kOHRwSWNIalBxTzBuQm43RG5K?=
 =?utf-8?B?eEM2c3Q1T3I2aGJpcVpTRjg0aEtSSHZCN3RRaGtvWjBEcHZPY1k3QmxVZ2xi?=
 =?utf-8?B?MW9yT3NmWTkrNVBBWnV0Vk5VU0xBUUJhaWRjazN0V0orcTNDV2ZIdlVpaWxG?=
 =?utf-8?B?TjloQzdyb3RRelhMZHByQ3ZVeDAzUG1OV3lYVGlPby9aZ0dxYit0WlR5VmRo?=
 =?utf-8?B?ZGhNL2Eybzl6TFdkZ09ZMkE3c29mdUIxbDA3Y1FBT25rMFRBNnVQNEowdWJk?=
 =?utf-8?B?K0ZEWUt4ZWRtc0pkeTQ5eEFyMThLWVFaYzVwY0VaY0V0dDZHS2NBNGhVWEdD?=
 =?utf-8?B?QUNCK3JDbEEzMnhlNWozZXF3dk82d0lhUWxzdkZtYXBCM1p3LzAxQmFsU3Rh?=
 =?utf-8?B?UGhuU0hraUdGNmIrTWNkVlpKZ1pOMWpha3RUdFdjKzdpL1ZrdTR5aWx0aTMw?=
 =?utf-8?B?bmxEeTdRRldCd2lPT3p4dzVvd0llVzEyS2lpNndOL25EL1NSZy8yN0kwcEM3?=
 =?utf-8?B?NURXVGhvMTkwZmlibnEyYmZRRWRpZkFJYnR2bEdma2NUayt6eW51ekY0cEpK?=
 =?utf-8?B?V2dHZk91NHdmVzFRb1RTNWRlV1ZpK2d1NEpNdHpJTkh0Y1E0QUYzOFljUkYw?=
 =?utf-8?B?NUludzV4cTlteml6MTVvTk1NemhpNUJrY25EaTNvZ1A4V0tGU1pjaHJJVUxK?=
 =?utf-8?B?SzJEcmxnWUZ4NCt1dm0yWmo3ZVlPWnNlV2FTZUloZmkvVkdVcXRPMTFRZi9o?=
 =?utf-8?B?enkyRHYraFZUZkVDVC9kR0VtcE8vRnBlSDJTcEFSZmNUUXBHaFFvRmRTVXg5?=
 =?utf-8?B?UWpneFBMMkxBc3VPWDBmczBEZVF2TUZ4dTNTUU1lVVYwbW0wVlJXeURIamN0?=
 =?utf-8?B?ZGwrUmVIU28vKytLeDZvbk91ajdlWmw2QWo2QTc3S0N1eFpNRlg1dVJFeWZR?=
 =?utf-8?B?dGpsY0s4T0xOUFQ1VEtRRk82SDIxUmNKRWVKYksyUnIzUzRqM0NZK3ljRlAx?=
 =?utf-8?B?V3A4akJZZnhLWnZVWUJud1ZxRFZCelY1VUx0eE0wTzZybkNzUWNXSnlicHdG?=
 =?utf-8?B?TGxXdWJXVWlMV1NzKy9MRnVVZVR3bjZIeHNUWENZeFFnS3g5M0tBdk1DZ3Vw?=
 =?utf-8?B?T0Ntb0JvUjZsaVRqS2I3RWNDZmEvdUxPSERHZW5WM2o5OUNXTFRDdkx2bzZn?=
 =?utf-8?B?WFJRWHdVRWNpK3ZZMXZ0TVpKbExWTHRCNm82OEpXOHdtVGxkZ3RyR2l6UkxN?=
 =?utf-8?B?V1ZUU2pIa0dUNkJycllkR2ZkQ3BSTThDL0NOaFJDcWZwZ2tSb205MkNHdUlr?=
 =?utf-8?B?cDdISFhJQU1zQnlEVkNZaVpzQ3ZsWklveE1JdVpiLzJKdzZlaUFWSmx0WHdp?=
 =?utf-8?B?eWJZWVVIQnVGblozK3FSRG9YSDgvc2kvM0dJd3d1SmFsaVZnWE1hRU5BNURM?=
 =?utf-8?B?N1VLakNaMFdWekpPdFVWNzFTSTRHRGJ1M2FDVlpVS0NDdHNUa0lXY2VmVEh6?=
 =?utf-8?B?cHd2L2xrZjJYMjRQUjRTL0tkV1N2czNvZ1R6QWhyWW90ZFFGc0NhRENLWjhF?=
 =?utf-8?B?dmZnY2djam5xYkFuUi9RQk1pZGNvc2kzNTRGMWtXS0d5Z3pLc0k2NmM4b01B?=
 =?utf-8?B?eTlVUG1CZWI0M29INVkzZGRaSVhsUThmRUVMNlVNTGFDNm9ob1ZwVkZBNHZT?=
 =?utf-8?B?VHdEbHF1YUVtUWtyei9NajlheUN0QzNuRnBlbHFQMDIvaVZIRW93NDJobi9O?=
 =?utf-8?B?VlprZUVJOFFDajVYV0YwaElqUVdQd3hsc2twQ3BRUmxTaDhZc0JYL282Njdw?=
 =?utf-8?B?NWlsZjh6bllJb1JQcldkVFFvb2QyajRMSW93c1VIYmxlSE1DWThJV3VrbktW?=
 =?utf-8?B?dEtHNW05RnJZT3Bad3NWaDd6KzRpVzBDaTJaYjhNemZSK2VlWDB1bkptSkkr?=
 =?utf-8?B?dGh4KzczbkpEYmVWZk1pQjJTczRnTlpGVnd5VWxaMVJKc2lYVEFpMDhORFZX?=
 =?utf-8?B?eTdBYTF6bDBwcUVvZkFaMFIxTHlHNE9QSzZoVGNDMGVVZkJnbFRxOEk2aTFl?=
 =?utf-8?B?Sm0vUUNycGxyRGRZZFl2VE9jQ25tZ040U2hpYjUwRHdwemx1YThOVTl6UUdq?=
 =?utf-8?B?YnFDZ0VyQzFNZjRvMmhpWW92V1dRc05XUlhPeEV5cm81aTNGVTBZQlhlS3Z4?=
 =?utf-8?B?Y2xBeFg5TWJkM2hZMUJ3WnBnd1k0ZC85Syt4OUdYbkMzTjZ2ekN4dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de0f6ed-11d7-48f7-dea7-08df3c7024b0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 01:40:46.1261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTXmOb6rKjM1qKt+T7ZepuP6vjIUElN5tmuuTmLfFEOiSUZMVPQtck/GFmmk1dxTGqg4nhroxthhp5GHorQHwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999225
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 5:38 PM, Danilo Krummrich wrote:
> On Sat Nov 7, 2026 at 1:39 AM CET, John Hubbard wrote:
>> Specifically, (as you mention above), I had to add "retained/" to the
>> directory path in order to retrieve the logs. That is awkward, because
>> that means that if I ask for gsp_keep_logs=1, now I have to know/remember
>> that they are in:
>>
>>     /sys/kernel/debug/nova-core/retained/<BDF>/
>>
>> instead of:
>>
>>     /sys/kernel/debug/nova-core/<BDF>
>>
>> We should try hard to avoid such complications, especially given that
>> debugging is often done when one has a thousand other complicated things
>> going on at the same time, late at night, too.
> 
> It doesn't bother me too much, but I think the concern is fair.
> 
> The retained directory keeps a clear separation between live buffers and
> retained buffers, but I don't think that's a strong reason to keep it.
> 
> In nouveau we don't have that separation either, but nouveau also keeps the
> retained buffers until module unload. I.e. after the first retention nouveau
> never exposes new buffers (including the live ones) unless you reload the
> module. This works, but can be rather unexpected when e.g. doing multiple
> rebinds via sysfs.
> 
> Rebinding via sysfs can be especially useful in multi-GPU setups, where you
> don't want to unbind all GPUs by unloading the module.
> 
> So, getting rid of retained/ is fine, but let's not follow what nouveau does.
> Instead, let's make the same files point to the live buffers when the device is
> bound and otherwise let them point at the retained buffers.

This sounds right and proper, yes. :)


thanks,
-- 
John Hubbard

