Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA50606A336
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OEMBlPW3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D257A10E009;
	Thu, 26 Nov 2026 06:49:00 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F65E10E009
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYgDtr9b9TUMWWj/2akWv0QHDkT3RnVGqAN3EF+V8gAwFmAr2KQMEFWOS7KHv9k6x595Ja4Z02LSTuz7HR+KVE1kTW6DYbPiFvT2xkmMOhcwKOt3w/xgwfmnYKDy7N7Oo5V1nWcfbmBqxwOB5NbS54aEYGWpS9tjXqtDCltSreg08bJb/A00nXhFJGv2ykg10sohFX9ynViTuTuaXsiQtfnuqc3V2bBHrWb0Zbw4XP6bqrBBTEDsCFfmtv6VIlTOvgzg/ZIWHwEg3+I/ApqTuk3KXDcWPAsg9JSSRwB0e8w3mDj9xMSplkkE3zwyd2G7qFNPaY8+2laFO9bhJEXtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZOzziPXDm5aUyjQ+GO6gzR3bBMUqeq3eFuKV6mmfvs=;
 b=i/A+yRHVprw0QDBbNodw3xV44dtPG+gP7+bZBbAhVzpwxqckR6a3VD9TpluB7opVVxxbgSZcqoFmeJoODEhLWUIXi5z9WJO1r3QCxIjY2KCIu0dkQsFWGT76kBGsHIY0bOzoiUxlx3V0iyEiFRnc72a3btsfeXPVwirAAg2MIk9ukpEO/YRpcB2mWQL58I4YJHB15D10Y0z3fNfmMD5EPtVc+FLiFUgIMovlqZFqBVivWyLLcGjzRqiJSlxupAsSnbNCc1I6agz6VC5hQkRwH/wy/rmT1utJxfFTP9Kkkt9bc5kryMnCsXEPwU0kTczkaGiUPw4dvv2tvmMVNvjW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZOzziPXDm5aUyjQ+GO6gzR3bBMUqeq3eFuKV6mmfvs=;
 b=OEMBlPW3RoAiOr6ruVPFwYal0ZrqEehuOm2ST1qYjgkqJzTIxNuHS2biIOfDzIiQfA4URFMo9XSWm33/qxh6KWbDfxubuwLW4l4Keqnarkt5n+RMaNUzy2WPxzRNUVXlkn9LJLu8HPeBF82WcXcINc9gl+YE27ns1yyY/EnF1PNZ1Erm6ntuTKa2iqxRCTR96yovQl0U7hgKDVm7IWZ35IHBhn3eC0AjYDgWlUtMoIaBqdiGjj2+Dg/zT1uEwEV+wTyZdnLMkJPXzQ4aWITD9/RIOwJQizxWfkY3/xpY1aiTza7GbDPcR+Wc5V6VBQ5+PdEsBR+fmOIYb2OIYQ6UiQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 06:48:50 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0639.012; Thu, 26 Nov 2026
 06:48:50 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH] gpu: host1x: Document the get, put,
 mmap and munmap operations
Date: Thu, 26 Nov 2026 15:48:46 +0900
Message-ID: <UAzdHWBlSIO_jTuii3HiZg@nvidia.com>
In-Reply-To: <20261125172022.2344949-1-takano32@gmail.com>
References: <20261125172022.2344949-1-takano32@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OS7PR01CA0132.jpnprd01.prod.outlook.com
 (2603:1096:604:24e::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 76234d0b-f90a-4ef7-d241-08df4b8953f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|23010399003|366016|376014|10067099003|56012099006|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261009223027099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: sFfMkiGBNcR9pZBGBxUC1at/jepUsZHu7wh1NXUCyF8lXo2ONK8XSp66p2OP/PsqCITk5nlAoIBhWdLu3LpQ2nEKWaNhAuaXhY7aTvgoUAjWdeped+lh8NCeGcabo/3keneMTefUoQ/mrbwYOHRU/hiV+NvyZEaZDLECynOdD+YpsD/ufFcL1ew/6q3Ntf10ndd3z37ag/iowS2LDvO5GXlyavkmJLIQbvTTvxd4UeW+/l05mx1SapxtUJRKPDrdzw1puCAGBRBZBtkG/c7YSaRMciTAq3fTSeVihT4J7MpoP3mXruWkyptwqHKU9GN9Cg0pf1p5brR+paj59THjcbbMKt/NBMnP+Pu17w1lXZ3VS5YqFmKnPzMz6x0eT/F2jrK9r5ylni9WCYAISYbej+U5zn+1vlvlbpgUqxIhNx39LlhoJIr0R4RJGKja26BZe4Fjwaw9xBW8RQkON+geIpFlvSUDZ8bft/b9cs3ZTPmFoeLU7NeNZ6AHCufhXd5vxC6DjjlEdWUGqljF7mX8Y/21hPDyIwWBRjd1LX5iWKpQkQOfCj6S7LQijDz8J13O9GxaKWmjANkIh9JQt0x1lWIo2h8mmou7I75OEMXsPRRokQnUV0UP89SGehPtevCYtWKm3pl4jYJ3utfhvFtDiOJq7geXTt7LkaITz7W22go=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261009223027099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aktDS2lkUzdnMHBMd0Q2SUp5dTg3RmdsV21tZElIc2dwcW9HU1p6aHU5Z0hF?=
 =?utf-8?B?RTAxZ2s0dmVRbmc3emdxTlcyUVRBQVlxeHdlaHZvak9XU0RGcnNzZjVHMXlY?=
 =?utf-8?B?aUlvc3hvaEFUeXpZUHpabGNNS3QzUUg4U216TkRQSDVhM1V3MWRaZWs0ZWFI?=
 =?utf-8?B?MU15SjJZWEU4SVgxTUFNYlNrN2NNbFdsejcyOFJveVJYWWJOTkUyaXNYRTha?=
 =?utf-8?B?S2tSL3dMYmJTZGFDM2cxa1VaN1prRTgvdE9JUDRVTGx3Rm1TLzVleVZ0bUlp?=
 =?utf-8?B?a3dTbmtpNjU5alhXZnIveTF5YnN2STVVb1F6aDRuMzFUVU5wYk92b0llWEs1?=
 =?utf-8?B?MFYzV0lrYW5ReXhqeWZETjloYVNCRGhHN2dnbU9pTkppZExiSGpEUHZqM0Zk?=
 =?utf-8?B?NE1lRnpNbjBsMUxFT043elZqSFd6U1hCSzhuSkFyRGltVndqb1dBcnJvS2VP?=
 =?utf-8?B?RW5ySlU1cko3ZkU1dVRpN0x0S1BhVGFvOXR1YmtMVS9oNVN4ajZhZHphTUNw?=
 =?utf-8?B?OHVjenpuL2h1VGJnSHNiZS92OSt2NmtHT1pKWHlSOFlXdExCVm14d09jMW1z?=
 =?utf-8?B?MmpiT00xUkFIaUU1ckVXSk5xb0UxQnlVL2djUVRnNHN1M09jaGJyZng0QVFD?=
 =?utf-8?B?aGlSLzhXdmdtcnAzVktOS3VuS2tkN3I5WkNzUDFNOFExcG9JTVhXcnptNjMx?=
 =?utf-8?B?ZVIrVVRibFpIcmQza1YvN2kyY0FDZmorOVl6U0tVbGU4T21XT3FxMlBVWW9V?=
 =?utf-8?B?RXhnRG5HZXF4U2ZSQkFuTm9WRFYzUXY1Wkxuc0xLMGdtU0RRdC9YYkVML0FE?=
 =?utf-8?B?bnRlR2IyM1h6ekw3M042bXRod0RKTVliZjFYU2FwZFVaUENHMzc2NGppNGw5?=
 =?utf-8?B?cTM3TmxXa3VSL3c3NWROVjlNSHlxSFJLbFNlZDRBT202MEp1cDNVNUl1TDB1?=
 =?utf-8?B?THdTbXBES3BwSm53OERodSs2cVRVa08zdG80R3NtcE5heFdGWFZnQWhtZVZt?=
 =?utf-8?B?YjZiQk1zeUNJTEZBOWh5SEx0Wkl4Z0xJK1BmQkwzOXlGRkZqNUtIMHQ1dXVD?=
 =?utf-8?B?TDZBQTBMTUJWN1E3eWJJejhBSXcybDBkelhXWGI1dEhXb1h5TmNMeFBHdUVL?=
 =?utf-8?B?bWZHVWlWQ1Z4RmpmWVpvLzZBYkMraHhLTkxsNjJ4cmNUUi9WbkM2VlNuekov?=
 =?utf-8?B?em5Fb3ZIbUdLR01Bc0NuR0kwU2JkenVnZWlsNW94WXFTZUdzbUhTdlEySmMz?=
 =?utf-8?B?eVhXRVBpbW9WdVlWWFlJRWtNbHhXMnJMSnZnME8xbkoySXdKWVRUZVYzQ214?=
 =?utf-8?B?d3loZVk3TjhkUGdvbUo5a1BydlU2M1M3VElFalFaRkJVMmFKcjNhYVhMZUxI?=
 =?utf-8?B?L24vdGx1TElKTHp1bThBTFN6MmVMdnRTRm5DY2pad0ZJQlhpSm82U3djS20w?=
 =?utf-8?B?blBhSFBNNXhvYVgraFg0K3VzWktBZ3AwM0hCSU01VWswNjhiTXR3Z2ZZZjFy?=
 =?utf-8?B?L0cwaTY0VlplcHRTUXV5TDIyUkljcXczQzJITWQvdXY5VTVHYTQ1cVZnTlcz?=
 =?utf-8?B?clN4Rmk3Q0F6VndSdytwVjd2MU5qbXlBMGIyUnBtdFFKNk44MnFVdjlBdFFC?=
 =?utf-8?B?TFhIQlU5SWREbXdUOXJVbURwb0VHTktFOWNHQWNFd0xkZUU0aUo3YS9SSkll?=
 =?utf-8?B?Q2dNVm5MZ0JKUEZBamdxT1N0VmV3OHlnRmxXRkQxMm45RXk0ZEZQeXdaOEJ3?=
 =?utf-8?B?ZVRLOG8zZmdGSjZob2pkcnhzZEFhZjdTUEVtZ3lTeXVLMllkdTlCYTlCUlVS?=
 =?utf-8?B?K2QwblJSd3VPdHZ5Q1Z6ZWJncUZaTTBqdGxML0NvbkpVN2pyY3d0ZC96aklS?=
 =?utf-8?B?OHFKWnBTNm1PZ2NQTXhoQkdoNVhFOXpSQzFxWXk0czh3eDk5aGwrdXRtWTdP?=
 =?utf-8?B?RzFwQlhhTW42SnBPODhTb3FDT04yWExsTjVUSGw4bXRjMzJsZDVJYUNoL1E4?=
 =?utf-8?B?eS9OelVDSVdybUQzNStTVjZqR05LLzhlbzcwZzZSb2hvQlQ1cHRYQW9md2NN?=
 =?utf-8?B?WjZEaVB6K3FkelJNdGRFbS9ZY1Y3ajVZck8xMXhUYWZDejN5UzNLdWQ2Q3Fo?=
 =?utf-8?B?YVgybTVyT2d2N3VMd0Rqb1JnUXIvTlNaRGdzRFhES3M5K3U3Q0VCcGUwZWFq?=
 =?utf-8?B?K05QcHdYQ0Jza0JBdk9vMlZucEU0YTNTUmRaTVFFQW9RK1UrdWlxSzM1Yzlj?=
 =?utf-8?B?M202aklERnQxYnZERHhVQi9jREwzNUtTaTIxV3ZuVS9YSmxRc0x0TDdLbnFY?=
 =?utf-8?B?WnZuc3JKTDRZOEVLbnVqZ1d4WlhUWlAxeG13V3FGcTI4NTlqaVdoRm41cTVr?=
 =?utf-8?Q?H8N4hBpm98iAc7b0j4qGtpaqxCVwk8uam1Pa8AIWxexN7?=
X-MS-Exchange-AntiSpam-MessageData-1: 9GSCfFmZfTWe/g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76234d0b-f90a-4ef7-d241-08df4b8953f8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:48:50.3349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mr6HJYAp7e1iAzCEEL+d3KGYlKoNVVOZFujHBsX5yxhI/plm3bmSOav1K7ZsjMVLgGWu5VzmWoASKBjkYnT64w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thursday, November 26, 2026 2:20=E2=80=AFAM TAKANO Mitsuhiro wrote:
> struct host1x_bo_ops documents its pin and unpin operations but not the
> four that take a reference on a bo and map it into the kernel address
> space, so kernel-doc reports each of them as undescribed:
>=20
>   include/linux/host1x.h:159 struct member 'get' not described in 'host1x=
_bo_ops'
>   include/linux/host1x.h:159 struct member 'put' not described in 'host1x=
_bo_ops'
>   include/linux/host1x.h:159 struct member 'mmap' not described in 'host1=
x_bo_ops'
>   include/linux/host1x.h:159 struct member 'munmap' not described in 'hos=
t1x_bo_ops'
>=20
> Describe them from what the implementations do: get takes a reference and
> returns the bo, put drops the reference, mmap maps the bo into the kernel
> address space and returns the address, munmap unmaps the address that mma=
p
> returned.
>=20
> kernel-doc on the file prints eight warnings before the change and none
> after it.
>=20
> Written with Hermes Agent, an LLM assistant; the author reviewed it and r=
an
> kernel-doc on the file with and without the change.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
>  include/linux/host1x.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/linux/host1x.h b/include/linux/host1x.h
> index e7ba601b2afb..411a1c84eb61 100644
> --- a/include/linux/host1x.h
> +++ b/include/linux/host1x.h
> @@ -146,8 +146,12 @@ static inline struct host1x_bo_mapping *to_host1x_bo=
_mapping(struct kref *ref)
>  /**
>   * struct host1x_bo_ops - operations implemented by a host1x_bo provider
>   *
> + * @get: take a reference on the bo and return it.
> + * @put: drop a reference on the bo.
>   * @pin: create a DMA mapping. Implementation must not touch the bo's re=
fcount.
>   * @unpin: destroy a DMA mapping. Implementation must not touch the bo's=
 refcount.
> + * @mmap: map the bo into the kernel address space and return the addres=
s.
> + * @munmap: unmap the address @mmap returned.
>   */
>  struct host1x_bo_ops {
>  	struct host1x_bo *(*get)(struct host1x_bo *bo);
>=20
> base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
> --=20
> 2.53.0
>=20
>=20

Equivalent patch was already sent to the list.

Mikko



