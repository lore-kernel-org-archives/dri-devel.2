Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A0C606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DWqkCHYi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D50210E3EC;
	Tue, 20 Oct 2026 11:14:05 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2851110E3EC
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 11:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSRhKWfXIMrfby0FCQADJbg/1ckuxFX/d31OdNBPo4B+L46A4H8sRVgk6hPbX8Is/I1agGlFESSa4MT1a2DNZy16Ytad/F/cBjG1h9E0sqmb+U0REPNSILCAttVTYY8aXWOX02PqqIjsSwTU1P0eGauXw+jUdVjt63KZQxXavihBWSO3fID661aEcHdX9c3O4iqmKuTm9iASKEwD2KFpZOucTqxVbWGkYEnlx+DqviD84vyQ21H+QPZXxK0MR0uVkFArCDwOsQcR9gZRJhORC5vCt0+axeobN1p1nc5iRG9VRDDEQ+Mf5/2JPYxBM4G8xkC8WHazEmadnizkWuI/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE/ksJf+A36Gs0ey4f4eT8XG3v6og3bEKURfVOWHnUg=;
 b=eN0N3G2R6rwuqr/zXDCrHyOlvzgOlWPPg8hcq0NnJd7dv2OZiYzPW1kbsEIolPizP+5AeF/M/uT/SLsibssEeXQNpukOdL3yBGZn3k4BNbw7ynBfrdIEN1EL0GgJz1hNss45yu9JqPPwHRpGhyh6WFKZED+8faDp7zPIpf4pQo5FN/DNt4CVsJVmi74GvVT3b73LXeVQ02dJoD3gbSRsodRyreGqrilWt1ojLL+m7Y5jt5edUKHQRpLjZFS4UFcxd04YI45Y6aHDLBtpNjSz3WV3ugfQB3xfjCuvJqZngswj0QIRI91CX0GvatllO1ZUEEcu1js+jb4YgMcsjnCsJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE/ksJf+A36Gs0ey4f4eT8XG3v6og3bEKURfVOWHnUg=;
 b=DWqkCHYiBF4DOeVQZbSn1uHOqFUjeW5CoRmLMr903Z9SLn3ugWE/115KaM86Ssgq02YqtGrdxSCY8aWbPnmPBhDS/BQZFWFNOOAtwuQn2AHGia0/I5dVYLajsOPINv9lA9wuyZGGcSI1JUr1cHyB4t+sJClKRpMJt7DhouDY5xI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Tue, 20 Oct
 2026 11:13:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 11:13:54 +0000
Message-ID: <ff80ede1-d0be-46cc-9929-f53ecd961d82@amd.com>
Date: Tue, 20 Oct 2026 13:13:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm: Log recovery method with wedged event
To: Raag Jadav <raag.jadav@intel.com>, dri-devel@lists.freedesktop.org
Cc: riana.tauro@intel.com, mallesh.koujalagi@intel.com,
 matthew.brost@intel.com, rodrigo.vivi@intel.com, andrealmeid@igalia.com
References: <20261020022117.199831-1-raag.jadav@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261020022117.199831-1-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0407.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3bae17-45c6-415c-972b-08df2e9b3a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: d7KAfm0eApX3iGHcaIiVrGy/iLY0+j6/RWjAF25Pz8qqw52eaJF5A2dgsWYRG1DxAfvTcoMddjJqOmoP2rEpFX5qWuI3CRcUU9FsNfGAnONIdvgt4j52ATaPo3758r+JP1aqxA24fhUDPmb1VEQnLeiHpCcl06FsZTBDuakcCXNQxHUbXCC3WEJ57HNkwWDkIw9ca/FAWBhVeX4VAsGvOFxnkC5HK7AgUpC/Bgm3cLnKJ4UzeH7K436FD301ax4Z2WWhz0CGPitrZwq3XgJW4sRiwCq8EgftFPzOtamKtARN8UB5mmmz2sU6zt2bzFHEp0W2JiS3Pvo4GecsjHNHmGqG66OtPlrKV7NsjGJ4ZgZEMb7J+Kk2n9ZqOhw2UHHrhemLb+HyA6jYRrTkx0QJuihEVle+xR4ScyZKxoLIbLoXcMU5WPIuXk5yuH3wepA2asnuVteLYhRmvP59Ij4wGLiC6T0DvhjzCFWykQU4br062O4Avsd+xR/rtFf4ySU3bAX53CGsG6wcYZWGnlGUzxWJhUbSliLrnEgH7C1IBA+yL4HnRSvgZz4t3sjUm948zlKTYq1jfn0to5t2/buS9t8chSqUaggv7rAfFiXzbPJGRD6JSnB3zRcY0tp/V/aPeXgNn/sBVom9NhpNUSKHUJh/3t4olvSANA543W3uA30=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZGbzFZMTNpODVMb01KcFlwOTh6YjByNXY1cU9UTGlsN1M1d01lWDloYkkx?=
 =?utf-8?B?V2gvQzVKWlU1YmQ5WlJhdjhveGVVTzg2Z3FyZGhHTklOaGJFR3lxK2c4RWx1?=
 =?utf-8?B?Q1FJUmVkMk5UVHd0ZTVwK3o1RE12UnJQVWcxcUQ2aldoUjZKWW1SUDM5VW5m?=
 =?utf-8?B?b2svWHZaZjhUSW0wR0JvcEszSnl1MzA2YTZBVXhOODBFYUl1V01sWTB6OTZ5?=
 =?utf-8?B?b1BVTm4yeFlDWVU0dyt6WklyajZSK0Y0cVh1a3h4UUpsZ2M1YjNISW4yejYx?=
 =?utf-8?B?Q0l3U3lFdCtqZ3ppSWRtVUp4OW1pcytGMUlzY1plWXlvRHhqbWZOS1p4UmRn?=
 =?utf-8?B?RGJ3TktHUWNVakVmTG50Q3Z4clBodHc0ZE5nQzVDYzBTODdnYlhyd0F6QjRP?=
 =?utf-8?B?Z2RqeGJ1TE96c2cxQkk3UHVKeFdraFgybGxOQzFENnhBYjhFeWc0LytlMkZN?=
 =?utf-8?B?OFZYaUxtcDNDZnczZXlieWozVktPeDZ4UGNycWpybWpQRXN0bmNETWR0SEEy?=
 =?utf-8?B?VlBPaFV5YlZCQkQwSG1RaVVIWTlIdnZHNFFxN0hpT0c5bW5kSnVqMm10OVhj?=
 =?utf-8?B?U1J2cEt5Sk9iNlJQV1A4QWdXd3pYR0F3ZS9nYjQyWDh0VHB1dnpUSDdDSnly?=
 =?utf-8?B?bkwyRkM3VkNycjE2MEFOcWhJbk5udi9hb1lYbWhXcnJJMlY4Y0o4ckdEZjI5?=
 =?utf-8?B?eUg4bW1Jbm8zM3J1ZmtFeFN5RXcxMStaT3Bqekh6T1FQT0tKcXhZUFlLODVN?=
 =?utf-8?B?UExweXQwamIwbFdwSTdXRmJWRllDTHZ3YStwUDVUbWg0ZDBzclJrRC9kN3E2?=
 =?utf-8?B?T1FhSnEyQmdRV0JRT2RESERDUW5mNWZrZlViSHhTUXkra1F5VERuZjZJZ3lI?=
 =?utf-8?B?NkxNTG9YYTl1a2lXbzNGZTNTMlcyUW1EZzJKSFZ4bFhROFZhNDRaMWJwd0x5?=
 =?utf-8?B?b1YyZlZCRUkxZzY0eEZ0WisrL2VQT1FYNzlRWnhENFRsVTFzNXhRdllPUmM0?=
 =?utf-8?B?b3ZNVm80aWJiNFQ4bVhBS21Na3FabGVaTSsrc2Jyd05qTXFwOEx2R3EycjBY?=
 =?utf-8?B?UjZxcGRpbXdUSUdFRDh2UFJSL3Jjbis2cjJ0dWx2R3l0UEZLVnJ4eXErQUdx?=
 =?utf-8?B?YStUMll0Ui9ZVWdkSmlyZjNZSkFoM2htU01jMTJpei9tMHBKcWFSWHlmWVNs?=
 =?utf-8?B?ZEgxcWhtWXNpcW91UEhieXY5UDhjT084QVVsZ2xBbVZYcHZ6K05ZM2hkc2Zz?=
 =?utf-8?B?VThTRUd4WW1remp6d0hzWGlFZVh0T2JKOGprT2ZUTVBmUnJXWDJDbVZjRG8w?=
 =?utf-8?B?WnNBeUFRcnMwNlcwQ0R4OTlVUmtCQTRZbFlJUE5VcHBqeW5ialA0UnlIaVhD?=
 =?utf-8?B?TmczdmpueXZGOWdsTC9udzhkbXltVWFGQ0VhcldDOTJtOHpJM21uOHY1c08r?=
 =?utf-8?B?YlZsRjNFdStkcERBcC9QZUVnczM0TDhsK2RDN3V1VlByNHpGN2lad3FDcTFv?=
 =?utf-8?B?L1NxVHRXVFhsSkY1TmtPVFB2cEFKVXZYQm9yZFlvSzloNDZZN3lmajNRS2Fw?=
 =?utf-8?B?V09zeVNEL2JKVXI3am1XM1dhZGNEdGlkTmJqYkdKU3ptT1ZJdjJOdUpYWnFJ?=
 =?utf-8?B?dkRieWpjeHViVzZWZXFOeFNkUEJxZFcrSlJ6MlVzZFE0U2tDNDU1YkhkQk43?=
 =?utf-8?B?b3VJc01jYlgvOHpnY29MVHpkTms4MzAvdmdKbjFPd2ZramFiU3Z6UTQybThI?=
 =?utf-8?B?STRQMU1KOHIzWmNabFRGUmhtc1psNFhsaGZjN2VWQlJHMHN3eTN6WDlBTzlt?=
 =?utf-8?B?cEd1UWQrWHhCcldqOGVhZ0NhT0c1empscS9GZWxvMGlpTVpBaGVvN1ZFazVZ?=
 =?utf-8?B?RkpSbXR1TWV5Vy9yS3hZSEZPZGY5bnJvd3dRRkNJSVFvVW10dll5K2ZDZi80?=
 =?utf-8?B?cjNsVUVLMkEyangvbkpjUkR4UlJyUkl3akUzUW9CL3EwUzJwOVduNHhSOWRH?=
 =?utf-8?B?SnZMazVKbVVXY0RtZFdtYmY2Zm4zajBYTWxZOTZYckk0T2RPSzR5MGRPZTR4?=
 =?utf-8?B?VU1iREl2ckREK1dJejYxV1crOGNmTjU1dlNQaXpnTFpGNHdVUFBoc1BZMUlD?=
 =?utf-8?B?S0tvM0dHeWc5cEFkcEh1SER2cEJhUUNMTzlVMDFrdjR5Z1hYZ01HU1NTNmJs?=
 =?utf-8?B?Y0pWaXQ1a3NuTmdLaTVyQmF4ZUQrVEV3MWQwdmtaN21IcUc5Qy96Vzk1S1E2?=
 =?utf-8?B?ZWNjQWVuOXEwazlPUkh6Z0phajhmZGRuRzVFM1BQYU5ZYzZ5bytNcExEUXRT?=
 =?utf-8?Q?ZAGCgoyu2HqaCsh2Av?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3bae17-45c6-415c-972b-08df2e9b3a0f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 11:13:54.0501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTs7XBH16iFZ6g1kGryaPT2+CkfsCXIVv5XV/CV4Hs5wtqaMSNF5ZExOMJxjkrut
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 04:21, Raag Jadav wrote:
> Currently, drm_dev_wedged_event() logs a basic message of device being
> wedged, but doesn't print the recovery method used by the caller. Log it
> for easier bug report analysis.
> 
> While at it, as device wedging is a catastrophic event for the cases that
> do need recovery, distinguish them and raise their log level to drm_warn().
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
> v2: Distinguish between recovery and no recovery cases (Christian, Rodrigo)
> ---
>  drivers/gpu/drm/drm_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index cb53baa70995..7f8abb72f548 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -598,8 +598,10 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
>  		/* Caller is unsure about recovery, do the best we can at this point. */
>  		snprintf(event_string, sizeof(event_string), "%s", "WEDGED=unknown");
>  
> -	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
> -		 "but no recovery needed" : "needs recovery");
> +	if (method == DRM_WEDGE_RECOVERY_NONE)
> +		drm_info(dev, "device wedged, but no recovery needed\n");
> +	else
> +		drm_warn(dev, "device wedged with method %#lx, needs recovery\n", method);

That is still not ok.

Again device wedging is a perfectly normal part of operation and clearly doesn't deserves a warning.

As far as I can see userspace can spam the log with warnings by just submitting shaders with an endless loop in it.

Regards,
Christian.

>  
>  	if (info && (info->comm[0] != '\0') && (info->pid >= 0)) {
>  		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);

