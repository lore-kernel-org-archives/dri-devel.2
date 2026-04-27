Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFFFFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 11:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3250110E6D7;
	Mon, 27 Apr 2026 11:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j2l2uiCq";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 007E710E6D7
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 11:29:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGFyaOSncrTAw+wgGSIl5o/wSmcNqEyXVcCcZSn3J5R+7/sZdR8dsHONmAPdbSOhK9NVdGkLvuWCssXwK/0mSN4mUAcHpHSt9yjxxf8juDASVglBpJII/maTyQGSwZbbFsc0Rro45uJhkXhEIyYa//vB5YpVhr8mrXHFHgu3OEQd7BytFR/knKubq8MUfNn03KJw8w7QSvQzV8BkghwIRa0QX+mqrPN5/ANk3F2JRpIp/ISnqvhiVCttFQDHW9IYBehXrPIlfP3XP1NbS5CDDOwmTPbBACbCb+hFxsV3Jmlw8RAh60eU4j92A8wyaQTRCdAXaAU4XWHVmQpvgSUJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMuJL2fin0kqgme/7kgCmbMLQoFeq+sPsRtU3GNVQRI=;
 b=ucYUf/NgnlsLr5Whbc2oqG0Af9kzHtSjqsQbc+dSv1uJzpUkKUK/qzDtDH92L6vavgK0Y5nN0suHlCc7kgntHBIuJ2wC2A1mV/I0rjZsIa4WgLyOn7NoEoPOIwrV0oqOkutpbtDD+qpTk6qBE4bOAF6ixTm8IV6Vpcubf+MAx9w9RsBDKOq7buULNYxBB6x5vWPuYPSA+juxNZ3Z5lqmN19HS2SMt1XslOi0mYBcByJeY1Z1DQqHSe3fP0YG0HMV/cuIJ8IdX/IybHLwFLm1mNJhUXzA309UcoFGbRCVvc3QXzz0NosmhoBTvzavUtQqsx3yuzvwobT0W0WlWu3CEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMuJL2fin0kqgme/7kgCmbMLQoFeq+sPsRtU3GNVQRI=;
 b=j2l2uiCqKzf1JvDGbgcA7ABToYj4fUatfy4U+UPAtG2XMmlX2MXu3nzcAKK0X4I3y7eUqyXyVsyE/BJhZSKM0CcTFm1VTKPuc9s1ZjE/9rrBRCqGY6At22XFo2J0xTcXMpxV9lZkSBJtnrhHgLDA8vjteLW1AiEyv6lOx2xhWCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 11:29:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 11:29:54 +0000
Message-ID: <1b5f0648-6532-4b59-a1d4-21c470d17464@amd.com>
Date: Mon, 27 Apr 2026 13:29:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Finishing drm_exec cleanup
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 dri-devel@lists.freedesktop.org
References: <20260424092012.5694-1-christian.koenig@amd.com>
 <CAO6MGth7OXG64pBxdtHU67M+yQ7QM7rSFQTmT57_1sC6TQMK4w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAO6MGth7OXG64pBxdtHU67M+yQ7QM7rSFQTmT57_1sC6TQMK4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:408:e4::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 919ffc0a-e5b0-4827-9550-08dea4504d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: zUTAXnIEx7xo3vw/Ei9k5jlhlBErSLfZ45iWVolNqgoPnc55iQ9S3suIFvNzgGLNPSwxsdIJIIF6jIFCv5sgU8gse3imSfLgAzoR1ZeTB538yyC5iSJP7fD1TOfWiY2fD9aDMqb9aXUARtojp27bdbQS0BgTvMEL27Z4UmRRz/zJ+Zb/nL1i10Sq7PfbdPoFI4YW4TcoAGL2bX9cyWjnyPypK9ifKCikZDkpve+XHfowssPlgSMGVvdh1UV8ms1i0kQmGhUoY6Qn5qXMemLiBfKvdSR1AA2IkqppJNvEKzczCIY7sCXPDk+ZLQhX3HVP3YY8Qgu0Pn2zsNpKoWzNnv/6p0uERDogzqlB1BQh/QxBc2wvjLQ/UYU9EiNRTD1yKqbqn4f13aASTxt+AUcmIywH8R26kQD0QPiLyf8teAN6A/5hro97q2VLCB99dNQgyIA4oh4F9omG7bliqXqxL6KKFo5SywuDk9QkvPLGxlrfDNCDyTMgPePmcP4Lzg6xiOrbt3IsnbnZncVR8P20sp6v/EedSAhCZU0yMZIk3ys5L2t4YL65ssM6Qxxi1JfVZ1fb7a1tiNMvPrdA7dHPaU3FM0pjnK30QivlcRbZN9rAU6l3BapIIf6Qr9aa2NVflQuQ6985/fD1EhTuA8Jzfd24rz4JD6JMdp8vtFp3EeuktMWG5aAAhRHmdcu0QqRXEIDWXOofw3EhcrzJlymm79uvMMwJLdMO1ihzCRKq7F8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWl3VGJxcjVXanBzZjdYMlJYUUpKMVRnWEhKSm9yN0R4dUh0OWNuMHFBVnln?=
 =?utf-8?B?T1VFVzZSdy9RSUdwcUVtbHRzZFhaMW1yK3JmdHg4a1FmSVZ3Tm5WcmdQRDlR?=
 =?utf-8?B?RU9Cblg0WUFibGFWNkMrT0FBbytxcU0rMXRNRGpHOXJpYzhYNXhMODNlT1Bh?=
 =?utf-8?B?UWxUelpubDRUeXR0VmZNUGlhOTQxTTFpNm1lWWRqZmt2eURTY3F2RlJBLzNI?=
 =?utf-8?B?S2J1cU0wbDhkOEdWMlBxamdCWjVOd2phZXpsZHc3cTVnZlEzNjBld0Z1clFt?=
 =?utf-8?B?bExqRDNIYS9mQnhqWFYvQUNtWkNZOEMyWHM1b0w2dXZzTkFtbEFaK2Z5Tnlr?=
 =?utf-8?B?WEhQVGtveTVndDIyM0Y4bHZkbWxjeW1YUThnazJDV0V6NDlaNjQwc2NIZi9Q?=
 =?utf-8?B?RjNGMHYvdWlkK1NvMjdsaFVPY3BVZzNaajkveS95a0Z4YXVjRU9qWnZ1K1FD?=
 =?utf-8?B?ekd0UGZ1UnVCRVdqTzYzMXVwNksrNnhaNXlBNE5MQk9EYjRFbEdMTFVLNC9C?=
 =?utf-8?B?YUFCOVZHeTVDTGpLQUI0Z1I3R0ZlWDhRS1BmY25ZOWRzcjdJdFNiTjZRQ1RR?=
 =?utf-8?B?eWxmbE1Id2cvZDRGTnVpNGExTGNBU1NzcWpscXRLdHRIWGltNWxOSFNid3dq?=
 =?utf-8?B?SVdHb2FVRGJhL0RZa0Q5aGwvVVhMT01jU2o3eHJtdzVubWtSeHZBV1g1SDEx?=
 =?utf-8?B?S2hUa3lrZVJsYnFkbHQ4MDgwTkxuSzV2VHhYNTRBQ1E0M1dXZGFRSmhYY3Nh?=
 =?utf-8?B?L3BvY1BYQkthMFJrRWZ6cFhHWUFweDBPL3hJdEtxU09LTCtOcDdydUcrT3lB?=
 =?utf-8?B?QlpFbHMza0t0aExiZUhvakN0dGo0UCtpeU5OYlJtWTNrNkpscnFXQ0o1aHVE?=
 =?utf-8?B?dVVQbHZDYWVodWx4ZWNQTDVaVmtldHp5Z1BOekV3dnNWR3NHeTZIaGtVUXpm?=
 =?utf-8?B?a0RRdVpCcTY1MlFERExpOG1CbGJGRHFhYUZXUnI3SnZ5cEE4M1hUQUZUR3Jp?=
 =?utf-8?B?bFNZV1lHV1l6eTd0dU1aS3U3amVjamJsYnJOM0xzajVJdUpKV0xOSVpXb3B3?=
 =?utf-8?B?MSsyaWZla2ZnRWlVaU1TL2VBWE45SHF2WlE5cW1VSThCZ21WQUw1K2JtZ0Jy?=
 =?utf-8?B?V2NwMHBFU3ZjeHhRa1NvaStzVnBBMVE1ejQ0cWJvLzJEQUU2MFFMcldyWWJm?=
 =?utf-8?B?aTdPdEsxckZPUkhFRjNMeGFpUXlqemVHRXJ2UExYcUQrU09zR00vcGdOQU8r?=
 =?utf-8?B?NVR4SS9qVXBLTmVPOGttZjZDekI5Sk1EV2gvb1YzU3Z4TWtHZTl0ajE3TjV0?=
 =?utf-8?B?anJDMGdKSE5ZNTR3cldsSTYvR0MrcExGbUZPSW0yRk9TcnRjbzV6NHd0Qmdw?=
 =?utf-8?B?VUFpK2pwMk5wNk5xQjIwL0IxUC9BaG5wQ0lpYlVRZmdQSTFYakVuSUVHTERy?=
 =?utf-8?B?SG44anJIMTRRSXB2Z2RhM1lCR0lYVUR5VG9jd25CSlJWQUx3MVdWOFVpSHhu?=
 =?utf-8?B?Q0RVV3NqdWMzalp4MGRhYzRuTXd3MEN6d2FZSEMrZHoyOXNLblgycEtjN1Zz?=
 =?utf-8?B?RGxBVHlXL3d4OE5tMDZXbGoxZ0FwbFFYNEhvWjQzWEtRMEhGaC8weVZJeGJP?=
 =?utf-8?B?UHNlODVNaWNTd0IyUmV1OEx1VUZpd1h4dHdZWDlycFFVaGRHN0lYbGw2YkRM?=
 =?utf-8?B?MWhhV090NmJmaldWYmRmb1hZaEticklLQU0wTkYvd210d0N2RU5MblVEVWJa?=
 =?utf-8?B?ZUZuWHpZVUxlU1A3bWJZUzJMWmM1am5waFhYdzBPK3ZJWjlSUEl1NDc3anJE?=
 =?utf-8?B?ZGcrWXM0WHZkZGFVRUpEeHphcWtVbVkraWpMWkNHNjhNVkdFd053TWRLbVVS?=
 =?utf-8?B?dTRzenRYUFU5Y0ZrYm9IL3lUcGVOY1p5V2RlcWU3elZ4ZTVmcE9XWjFaL2li?=
 =?utf-8?B?YWtCa3pqQ3h3Q0wyalp4MHQ0ektIYmRtWk96Q0thdkdxaVdFZ2pFSDFLYTl2?=
 =?utf-8?B?OGlIbUc4MFRuVmM3Vm1US1hUVnlNcmI2Y0xTcEZLMThDeU5Ua1dKWGpLMFkr?=
 =?utf-8?B?dmJwV3c3OXgva3crY1ZiekFGS0ovNEdYaS9NWHN2M3NiN2pHUzh2OFBaRXlZ?=
 =?utf-8?B?WUFmTXRlTGc4UmltMkpEb0gyS0RnaWJlMlFLZGZiV0hzUWtyMUp2NUhMcW9L?=
 =?utf-8?B?VkhiTllaaHBSK1lpRFBNVWE5NzRRaHhqYzJ5TWo2aHk5ZU1YYVd0OU9lRFNF?=
 =?utf-8?B?U0xwaGdJcUJvQWJMTjA5Y1ZNemJHcmI2Sk4xRUM4MlRVYSt0ZmtsUjNGNzZt?=
 =?utf-8?Q?gPUHbOd12X6gesDLSn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919ffc0a-e5b0-4827-9550-08dea4504d96
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:29:54.2552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKZpdulI5r9Hb1vvh/oABDbj/lWafDQZTn40Vy5RCPQa28LcCAkPPPhUNGJgoub/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129
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

On 4/24/26 14:55, Ian Forbes wrote:
> When I tested this last time the first patch was fine but applying subsequent patches broke vmwgfx. I did get it to work but it required some hacks and at the time there was a major conflict with the ttm -> gem reference counting series. I will try again now that the reference counting changes are done but some changes will be needed in vmw_cotable_resize.

Yes since the ttm -> gem reference counting change is already completed it is now the patch set becomes a trivial replacing the old function with the new one.

Of hand I don't see any dependency with vmw_cotable_resize() any more, but it clearly needs some testing.

Thanks,
Christian.

> 
> On Fri, Apr 24, 2026 at 4:20 AM Christian König <ckoenig.leichtzumerken@gmail.com <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
> 
>     Hi Zack,
> 
>     VMWGFX is the only DRM driver who is still using the old ttm_execbuf
>     framework and while going over my TODO branches I've found that I never
>     upstreamed the patches to clean that up and fully move over to drm_exec.
> 
>     It should be a trivial 1 to 1 replacement now, but I can only compile
>     test it.
> 
>     There can be more cleanup on top of this, for example as far as I can
>     see vmw_resource_check_buffer() actually doesn't need a ticket. But this
>     isn't the topic of this patch set.
> 
>     Please let me know what you think since that would allow remove quite a
>     bunch of otherwise unmaintained code.
> 
>     Thanks,
>     Christian.
> 

