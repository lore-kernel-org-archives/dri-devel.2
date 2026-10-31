Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C01606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cMwYP2YK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B568D10E90A;
	Sat, 31 Oct 2026 01:58:31 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F94C10E907;
 Sat, 31 Oct 2026 01:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Auc+UQWT5RemVozKQODcRDZ/anGxXYIyidwA3r+R+F2UvgrmPbRIyScp6IF/5cSY/D4Wf73SbQthzhYQdX5ZJUW9sNbkvLkWx2u1zbaFOW1aXZSh4TkKIMMeDPR6LpkOuJ8v+E7InvwVBZXX2VbuLIsgmjNYTi0269af2jYmJKT4EPxfWa2Zxxwn+vjX86twgCbBivmlhNG7Hu43Xxyx8mXEVm3n7AkoEqzT7803UM5SZdv1HpR+5UfX0XBQQEnAtMP2FwT9vmpuSnNWwhXBXHnn1yBbbtdJAEjv4/4NPvN6X3+0VOiRFTqCR0qjlODP8p7F+LMgaykQViAK+NXGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXPcEx4+VV7OUKEnzoc8JHtbgGVJZOtNhbarnBrVY3g=;
 b=hOSLJpzlQ6sj4p+QWTPM41n9ldutK7Aud2N2P6A3L6lg62UTmUHjW0+OqGJ1JqzeyJlObbZmJOwd+JWnyxsrSS0gXCuFTy6L2ohautTE4MTgdcTsyk3PeJATf4psdlls1eD41zHgoB3PMCm7h0pnF5XncSdWVmkAs0DawXai9Q++6kKfQDA+ctzw6XP7l+MolXamgf7ahfQ6Sz098MEKRY9RkVSWjoFjrUbvrtGES6l5Ja4MrcSVwovq7bGYSfJOpE5XkaXSw8GedFmQWexSNqMSvCUIHE8sr4IDwCLaCTsu8fTa3K3scL5V94x+GyP80fAUlpm9CI1Ok2DfCn7TNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXPcEx4+VV7OUKEnzoc8JHtbgGVJZOtNhbarnBrVY3g=;
 b=cMwYP2YKVWLJ81cys/hUSY7JjAaGIEtk6blqX0kOEnYZSHaiUTrGnZMw9mLCEvA4mk7vCLb2fJyWlU+tZDVPOiTx3bKJ3AB9NkteP2QwiD3AE+UvnIggp+p/8+u11wWtpIvkGoYmQx8UweyLVmsiQw6KmCTpHvl72lECjyruY+I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18) by SN7PR12MB7420.namprd12.prod.outlook.com
 (2603:10b6:806:2a7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Sat, 31 Oct
 2026 01:58:19 +0000
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26]) by CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26%4]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 01:58:19 +0000
Message-ID: <f25f4726-17c1-4fdf-8fd2-d96e73fbb22a@amd.com>
Date: Fri, 30 Oct 2026 19:58:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Don't select zero V_TOTAL_MIN/MAX on
 DCN2 seamless boot
To: kyliepc@proton.me, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261022-dcn2-seamless-vtotal-v1-1-6ceb87f98629@proton.me>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20261022-dcn2-seamless-vtotal-v1-1-6ceb87f98629@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0124.namprd04.prod.outlook.com
 (2603:10b6:303:84::9) To CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY0PR12MB226969:EE_|SN7PR12MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: a101b893-1255-4384-077b-08df36f26f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|6133799003|261028144727099003|261009223027099003|261022105027099003|56012099006|261021121427099003|261026121527099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YnYNhJc57OBBROPsLsWpcEqdVBFy6mvq/JxRx01fgnA7saT4jZkmWaA3Ao2fyVgQViFAZGirjhfO4f3cuAFzJzd043NOyDsr1gjybvQPFmW4pAs4d0MwvLuby5tLTwqEHmaWdzfKZzlXcQzJuruQS8FaJim2LxHJUuLslURwMrp0Ort5/Yke76jibIPFmOg6QgwW3vVy9Fm8sLscsxV70XM6XaH4iR6tkJaG7d6aOhXL8AkxyyLbbABUZHa+PulvrK0K/8H7AdYLpVS1HJhfQ5tCmZBbL/lHYmojfyYsmgawCpelJsTNrBLeP/WglPWiHgU6eNjnU2mG10KAwiCQB7oCBSsLcUbcshKAE1hQNc00DYV70PfuuEoWiPP/Od9oi7ywmitJQDXL6aTELzri6M7fFfJw6iORFTFtAvGZpnYwwk9WMDe/WBmqZSwVPLGKV7PqliZeCZ10UjXUbP00AwBkKii2qU3F8cCu4egKPI3YpNqrutSQSPKNMBFlRDkQcNDX/9SuReI7EsqTYv8BOuOtI3yxZb9t62tq1FB0XhPv+1sFogqzfxBIqZ6ep1B/OM4hnuADLPch5UJ9JIXIC3zXDfSdBmaKzG1rynu1ihhIBgDMr6bfQjjzg1s3cXKyekpgl37d6cosUwx2DPnF7GI2MGovOmxWof5vJ88BO4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY0PR12MB226969.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(6133799003)(261028144727099003)(261009223027099003)(261022105027099003)(56012099006)(261021121427099003)(261026121527099003)(261026140227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aksyYytsRUtseGtvQjVFUi9tak1EOUsrYlBwd3ZkckxVeUpMbTJ0WVBMbWlN?=
 =?utf-8?B?d1J6T1pzZG5sSnBEQVpHYkRJQmxqc3BSRStlV0JXQWJZZ3NXNGo4eFZtdDNZ?=
 =?utf-8?B?SHRoQTlSSkxPSXhlN2p6eUpKdFNXSi9tV0t2N0NwVG10WHRMaTRYbGtuY00x?=
 =?utf-8?B?REVvdEMxcUxqanhla2Z0ditPZkJkU05jNXpzTEx1byt3TXhiWExQdFhDN3Uz?=
 =?utf-8?B?RlhvWDBYa3gwMGJtMmJJeTA4N2hvbVlxSWdQcGFmUDBIclVid3hsZERJUkRl?=
 =?utf-8?B?U1h2bndQZzhEYnlKUmNVeG8vNGtXRkNmZlNpbUNYSUxDRDVHaUVqWHZPQTNW?=
 =?utf-8?B?VVRTQXpRaXNManNuSFUycXY1dEprZUpPR2pOaDR2SUR3Zk14WEdMUEFJM2Jk?=
 =?utf-8?B?cm9rNEZoS1pMOXBhU21LUy8zZWhQVU9XZ3kyeGV3QnhIeHdocVZqTXhoWlFZ?=
 =?utf-8?B?Q1JKN2cydXFTSk1XT0RsTEV1Y3k5M3dEd1dFbEpsdE5USlc4SFZMVjc1dGlQ?=
 =?utf-8?B?K3UxVUlxYk1JZWxlVnAxdGt0N2ZkS1d1TjBXeGh5SDVzOXNuQ2xvb3JMYW9W?=
 =?utf-8?B?OUdSVzRlTmdlSVRIMjNUV2p2V3hlclphcjdsQXFBSGhKQWJ0T1NpSzJJY0pq?=
 =?utf-8?B?M3FCbXk3K25yTUlkNmdVZVJIckpzblNuWkFHdUhXeVZaSmhyc0RrYm5iN1BN?=
 =?utf-8?B?d2dnZVVmbWVPL1ZlSzVJZGZrTEZqc0s2T01wODZ0Yk5RV2lSY3VnT1ZtQjNZ?=
 =?utf-8?B?T2lxZFZKRGJRaTI1VHMvMXd1cG9NNGprZGdEMWJxMjNTQWlCaVMwSkUzMFJH?=
 =?utf-8?B?OFI5bkUrOHBUaUpZSndJS0l2MUEwMUdYekxLRVN2d3I5SnVZSVJwZ2VsOVh5?=
 =?utf-8?B?blZ2dGVkeU8vVGc4QnRjMGMwcURKMHhRVnJ2aDBNQ2VMSG9wVWM3Ym9KTXZl?=
 =?utf-8?B?T3htQnBkRWlWM0x4emV2N3ZtUThjTzN4dlhwck1TTHUyWmN5dWFYQTFHWUZ5?=
 =?utf-8?B?cmxNYVF4a2lDUVh5NGp6ZEZjN1VBSlcyT2VBSkpQSWpuenk4T3h3Y1kzQ1Nn?=
 =?utf-8?B?UlNmZldpM0EwYkFWTUZ4QThwRGNFTktES01OSzlNVjd6bGErM0VyRkVwbXhR?=
 =?utf-8?B?M3N5Ry8rUzVIUDgzQTkwN2JuUnV0LzFGSTdrVDIwZ2RzbWlnNVdNN0QrVzVC?=
 =?utf-8?B?NnVZNnU3QVYvdzZKMk1LeE5ZdU03RTdYd1MxbUFrbDg3VWs2M2VKL2JROVls?=
 =?utf-8?B?ZlNuWE9wZ2tIQ1IxNlVpWGdaeGJjYU9sbDQ4SWJtUFdrcTVkUnhCa29tMmV5?=
 =?utf-8?B?TndMdHNMejhFUit5V0wxQWlDM3lLY0thcjRIeGt5aUNrZHBTMzlvTS9YUW1B?=
 =?utf-8?B?aHJxUC9BWU5ZaTZLY2NxNnBPMXd5akNEaTJwUkNPL3ErTW4rbEJkZnJHazdq?=
 =?utf-8?B?NHVFdzN3d2c1THJ0d09JdmVDTndIRnlSRHV3TURNWXYyR2p1NlFSd0NQcFI3?=
 =?utf-8?B?c1ZvKzZsanF3ZEpwVGFUdWhDYVMrSEpoVEQyVG5YYVBRUGJ1eGRpYm80TVY4?=
 =?utf-8?B?VjB1NEpOTEVKUTlLZ01QdlVuWUFOK0UyenNlejdqakVkVStFbHhjMG5EQ0NM?=
 =?utf-8?B?RnNudUNkZ2pRSGtHUm5td094eW5Jb2ovUGlUeXQxcThVL2pNWE1yUFIxckp6?=
 =?utf-8?B?REFRNXcrMG52dVM5ZHlIdi9Dam4zc1BNc3V6Zk01TmpFUlpUU1l4Y01TdmYx?=
 =?utf-8?B?M2xvRTBXbmd2UzBuSVhNVDlWS0l4SmJjUDZlL3l6U0hTRGFSdVhBRTh6dWd4?=
 =?utf-8?B?UkpEcUtjeUpsRlZmWXFJMzFUdUR4MHZ3SzQ1VmRzR0lUNjhybmdJcWU3Mk9x?=
 =?utf-8?B?c09oMHVEUVB0N09VRlNkUDladEY4VGFVUkZBaDI3TTRxTnBBZjNzVGI3ZnBq?=
 =?utf-8?B?bWxDdFhXN0JqbERPSG5yQitSb3pJL1pXRWRKeHZxRkRvSjg4Smt2YlZUbEl5?=
 =?utf-8?B?WThZUjFZV2IzS3Mxb0s2UTlZWjF2dGhpVUE0MzlWY2g2S0Y0UExkbUJZSXV1?=
 =?utf-8?B?ckdZbG1QRHVhTllBdzc4blRCTHBiNXJ6ZGF4Vi8rRHBVTU1mZG9MSm5hYzFM?=
 =?utf-8?B?ZFJWVTlsdDNmc01XQjBScVBJSEp2RlluOWlUbTE1RTFYeW9yT0Mya2tkOTVn?=
 =?utf-8?B?TGJBdkxVS3V5OS82WUZYbTBacllJLzZOb1dJSmxNMTkzbUlYVDQ4WTl3Z2Rl?=
 =?utf-8?B?blRSZVRDVU1Jb3RGbEJVR3d4SDYzNndoS0QyQ2I3NkRBK3Urek50b1lrMVdO?=
 =?utf-8?Q?XQ0wA1F4xSwcEb+F7/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a101b893-1255-4384-077b-08df36f26f6d
X-MS-Exchange-CrossTenant-AuthSource: CY0PR12MB226969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 01:58:19.0002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXsWaWh/5Lia+NYEW7dX88roFMcarB5GlZFl8NffZKYVYDu7zcCVxMN2I++ZPw00Ofd3dHdbu7Gv/HTmQ0On7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This affects more than DCN2, but I can fix patch title by removing "DCN2".

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 10/22/26 07:30, Kylie C via B4 Relay wrote:
> [Some people who received this message don't often get email from devnull+kyliepc.proton.me@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Kylie C <kyliepc@proton.me>
> 
> Initialize V_TOTAL_MIN/MAX to V_TOTAL before enabling the selectors if
> they are still 0, as optc1_program_timing() does without seamless boot.
> 
> Tested on Renoir (DCN 2.1) eDP with amdgpu.seamless=1.
> 
> This removes the flash between the bios logo & plymouth on my laptop.
> 
> Signed-off-by: Kylie C <kyliepc@proton.me>
> ---
> Fixes the black screen when enabling amdgpu.seamless=1 on Renoir APU
> 
> With this plymouth smooth boot is possible on this hardware
> ---
>   drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
> index 73cc8a713..2cdfe3d7a 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
> @@ -449,6 +449,13 @@ void optc2_lock_doublebuffer_disable(struct timing_generator *optc)
>   void optc2_setup_manual_trigger(struct timing_generator *optc)
>   {
>          struct optc *optc1 = DCN10TG_FROM_TG(optc);
> +       uint32_t v_total, v_total_max;
> +
> +       REG_GET(OTG_V_TOTAL_MAX, OTG_V_TOTAL_MAX, &v_total_max);
> +       if (!v_total_max) {
> +               REG_GET(OTG_V_TOTAL, OTG_V_TOTAL, &v_total);
> +               optc->funcs->set_vtotal_min_max(optc, v_total, v_total);
> +       }
> 
>          /* Set the min/max selectors unconditionally so that
>           * DMCUB fw may change OTG timings when necessary
> 
> ---
> base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
> change-id: 20261022-dcn2-seamless-vtotal-351d08d2df54
> 
> Best regards,
> --
> Kylie C <kyliepc@proton.me>

