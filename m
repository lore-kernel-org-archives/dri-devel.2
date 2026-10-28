Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0246606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 01:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V/wnsVeR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C60010E4FD;
	Wed, 28 Oct 2026 01:35:31 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013004.outbound.protection.outlook.com
 [40.107.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D65B10F934
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 01:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aG/3AGKbILurCS1A1gm+xmDLEkXaWbVqBc/i5skdUB984mcGjVpogqfiBBOzLFB75TqazzCYz9wMQlkaRSzVFrEBOl1QvHVvf99gQptpiy19LuEeKpB5rQEHIBHa0LI6w3avU+ssG0kChIFs+1vzcKNQxxDQm9HjUcMIz4cij6gkiegPS6yUcHSdZdGQlJEqh7LCFo89yTBhetFMD2LmLU/SOTF56G9tFG5OFocmpIhCCIdYaBNQVSxvSaePvytPSP/ozoNdvFzas62lsiriiZcSaGEvxhltKBPC1lCUgZc4IYYveDEl55xLX4fjjCFFRYrVO9nIN0ysQE/vCZ4HdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nroL07Ez31MraJtBizjQdUndlwxz18OLvVwvK3tDq5k=;
 b=IQ2Th7RAWNAKvJ0HNLLOz5XtRx8p92cLZ9g+F6oS2qkmDnYcS6Mi1o0/PJ3tZXSMJn82sPTiyJPRpm+JUH78PtIuJ57ow8kBZTE0SNtFUM2IlZ1Mg0xAD2cTUGP75S1y8iLE9XYHBljPuK1/VcD5cH5e6/qFNx2s8iySvxd5g6moxcT/0xzy4ffgvlysNohFN3ZIJY8ryoD5u2kvzWe1obZCrvZ1/o2aHJWGvAF2ovVwTwb8oYsn8f8NdlZzElf2fjxo0nCPmIPU0llSCLC6jOnqLr4m+aaHhQ6/XaCCYUzYmEzQTgh+hlSdHss3ACiYUFMPNhh4wzy8a4LH81C7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nroL07Ez31MraJtBizjQdUndlwxz18OLvVwvK3tDq5k=;
 b=V/wnsVeRSsTbQ3C6Bb8Ue4mcdjrl7T6bGObCoQsVWfRI5eBlIBliJdgocE95hvPJEkNdDxqi0WmgKX1ilo+rCSKZQlJbNQpQmy29kCCf6tZgXBDMxUFv0G8M3qGNUq/BK/5JNgQ6glFjxufRZJxJ1sq3NoANA+RXFSWFiH+TSGa2uKksD0qGUiCLFo1/jO4YiZoR9Ry8s2WZx5tO39lSKMYjbbbyZe/sGR+kR/h61qVXxoqHy7KnZD9UpOC9szbDcjcoqp64ttnD3cAW36+w5N+Xht0GwFl6WeBkhYcaOaIfNpTOlgnr67wW/gVzb/xxflLrF/ITKq2hz7Dmm/rn9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Wed, 28 Oct
 2026 01:35:18 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 01:35:17 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: devicetree@vger.kernel.org
Cc: devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v4 7/7] drm/tegra: Add support for 8-bit CPU interface
Date: Wed, 28 Oct 2026 10:35:13 +0900
Message-ID: <gXWEBbhSRWKBIHUcDXZu7w@nvidia.com>
In-Reply-To: <CAPVz0n1G0cDuUj7WRfj9YRgvMSd0sqSCjnir2p=QxUGu5BWTXQ@mail.gmail.com>
References: <20261022132259.240717-1-clamor95@gmail.com>
 <0g7damfVTZ2r6s4H0kv6Lg@nvidia.com>
 <CAPVz0n1G0cDuUj7WRfj9YRgvMSd0sqSCjnir2p=QxUGu5BWTXQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OS7P286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26c::11) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c3da22-aa2b-45ed-2d28-08df3493b8dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|10070799003|261026140227099003|11063799006|4143699003|10067099003|56012099006|261009223027099003|261021135927099003|261022113327099003|261022075727099003|261022105027099003|261021121427099003|261026121527099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: h/2t6ke+h9ykaZnYnw/+j9FT2Q2+jV7dcPDLHnbr2OvpSF8ynn6l7LJa9AwKkiwl0LkMNHDOuxx7p8teNiXXnWYTnoc00jh8WegSQYc+LzhlKqF+e15kiH3WhT37iDtqI9FPZXdFFu0CUB7itcQ+Iy3xBByJsnUvHG9XazrkIVyH10cQAJcTKU0VRZJvC5d54ZU5XFlNwnAux5V9ZlLGJrRJCRxJcJcsf7OZ+zNbhbmpmrcOvtzb/sEagnjKdrNgwrfeTfRfmng3aklAyb3FTKL4Zb26dY2YLNuGOPJYDDX/QW9xn2e4slrw9j2hYI6OypuOO6+b6iarxaZT0hpcw17Ta7SWisY/zfUYVj/fkUtGYnd7QtTQ6+CKQzY2dwVovGOCningUvqW1VlFgBMZzY+UX/kyC1VxnCZgzsFSG5PgD8XJBiL9Wh7qLQ9Oj1LwqNXN5+VEe4SdhjAYk8onGZQNlAWmc5l5906zN3q3sT6FCuijo99eiGFtEtJiExM8sNhjCN0MQl0Ap41i88oi8UI9ddbHqh6xfhFsRrw4cz0+V+ICtakvawjRKVFIRU0hW4s+PPYxCE9UZZmmoJ3QE5OQ/85iwjEOiehuWUxplAd9Epz26gexxNPKRLxQpQi4qq8fW3kje/+r35D+4HSnbPdGlZTzH+2YY5rzlWiBlPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10070799003)(261026140227099003)(11063799006)(4143699003)(10067099003)(56012099006)(261009223027099003)(261021135927099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026121527099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1pXWnBIbE1ndzQ2QTZyYmE0RVo1Q1RPZzRsdlZwYzN5alF5cDl2U29FN2Uv?=
 =?utf-8?B?NDVuVTRNeWpFcE5OYis1V2VFbHMvS3p5akpFSU81dmtobVlOdEF6d1BzSTFI?=
 =?utf-8?B?SWZVYlhaOGhhQnZ2Y0hXYzI3T1FrTGczTDZkd2Y1T1VRdXNQcWFyUzlnbVBD?=
 =?utf-8?B?TWdyb0c5eGVjVlZxLzBlcFBzZmRFNDI3c1FnN3JZdlB6S1lkZloreVBST1dv?=
 =?utf-8?B?RTJMbmg2MGFUT1g3WUp6a29QTHhCL3FTZlN0MEZOVi9va2VkeFprekRZaUQ4?=
 =?utf-8?B?R2JRcU5UMjRFNC93SmppbG9mU1RKYjdhUmRwNk4zalQ2aTdVVzh2c0I3UDBB?=
 =?utf-8?B?T0FxMml6LzQ2bkpqdE1jaHdTRFJoUjBlNU1nTWVVSU9nU1FWK3dQU3Rtai9O?=
 =?utf-8?B?NTRSY1ZTTGtkQzhBYVFYVVUzVkQrMjFrTUZkSlJ6MFVPMGRpUi9UaVhqTzRs?=
 =?utf-8?B?c2tmcHQvZmZrWHh2NFRMR09RU3FnTUlUaGwreUVHUjNva0p0MEVKbFBnSmM5?=
 =?utf-8?B?N1d4eHU4ZUZ6UytIbWNhZkpzK0JmQUFBUUVIV1RTMitFMmxrTmNwaUlOTGVZ?=
 =?utf-8?B?cVJ1dkVWemZheTNGVnc1dkRNelBZUE9sZ3hjWDJTc1JLdWJIb3hSa1JjWXZt?=
 =?utf-8?B?TDR5anBqNFM1QVEvNWNvTndRT3BYR3FmdG5QK2M0RHRuVjhoUVI2TzBKMGJu?=
 =?utf-8?B?MFJyNVA2TXRWRkw4Z0trR2YxRUwxWDl5YzN5cVU3Q3laUXhHb1VOY0xCWXdy?=
 =?utf-8?B?ampnSEViNENRc01hK2pqaTNQVzQwRktPbTlCd0F3MmFQeWhWMmlteXlYNmxH?=
 =?utf-8?B?T2pzUWFzc2cybk55U1R3RmlNbTJSVlNGa3FzUFlnT3NJdldUaEFNWmxjQzRL?=
 =?utf-8?B?dnY2bVhvTHg3UlNwd3Nrb2RDRnBVV3FyaHBUZnEwYjNqVDl0Ui9XaGsycGQ5?=
 =?utf-8?B?TFB2bjhEL3VjdnQ2cktQcFhoYk03R3UvNXZYaThNbGQvQTljRDd1TDk3VWxa?=
 =?utf-8?B?VGdhdStxUzQ3YXpLYVhwR0NhR2poYjBQbHNDU0RxdmZ6OU4zS1N4aU51NnVp?=
 =?utf-8?B?dmd1cEV5eHYvWXBaK0dqY1R2RzJERC9zRWJCWlliV1JadWZiNTF6dkE1WE51?=
 =?utf-8?B?OExMM2xsamh6TjR2RHQva2lNQkRISEZrRnV4c1I3akNpNVJReDJQd3U3dGVl?=
 =?utf-8?B?TEJnSGhrQmp0NjM5RnNRTWVWd3BGd2p5VXIvaG1kdWdIMGVmTHEyOU5vaXlT?=
 =?utf-8?B?YjJIVk5GRjE0VTJ5TVowK2VIUDNSSjBva1hyREszREE3eExYMS82aHhSMUJt?=
 =?utf-8?B?S0xlZVRzT3BvL1g1TTlVT0I1YWJCU1NNNTNtYzFCTElncEhEbzVCU1FzVEs5?=
 =?utf-8?B?bGpncUZHZDBSTVh5eEwzbnNXRzJ3Zi9LWUFNbjV4ODAyakd0Lyt1TFpBRXBx?=
 =?utf-8?B?SjNETEVCdzE4S3hCYU40R243YzBvWnBjRC90WFJmaWpsNkF1K2FBckR2ZnhV?=
 =?utf-8?B?dEhnWlNyUVhUa29CMTFhdVZ5OGhJanlKQ2FOMXFvdkFJYU8vcUR2d3A4YjRZ?=
 =?utf-8?B?ekJMc0dINDNZYzk3N3VZTlRxaFR4QWtpZ2dMZHozRHkwL1JKd3lFWGQydVhk?=
 =?utf-8?B?ZVMzYWhrNkU1bmJTTGZ4c2JjMTFiZ2hmUFl2RytPV2QxREROTitHU0dvRjBD?=
 =?utf-8?B?OG9oZVRhN044NCt2bXd0M0puSlF4OEtlMkdGRnBQa3VNUGtpU2xDZVNNU3k0?=
 =?utf-8?B?eVpZSW8waGRqUTJhSXJYaGtQWllSbUhCdlBGU2NDNFBzUVRwQVIvemRWczRS?=
 =?utf-8?B?dWdVWktCZGh5ajg4TU1LWEQvVEwzeDJiUjZPM1I0YkVPQVBDNUxJb0dvNHBy?=
 =?utf-8?B?TDk4VktZWFpMQnpOQ2dHUVloTGFYalEzZzc3QTB0c3dkNzNPOHQvOFRNZU4x?=
 =?utf-8?B?VjdrblZJT2FnSnVBek1SSEw2VTQ1SkR1K2RhZWVIcUhBMHAzZUhyN1lBVFJO?=
 =?utf-8?B?T052OWljbFE3UWtnb215b2xTcUxhemI1YS9XakEwU3N6OFpFcURhd0lkQVR3?=
 =?utf-8?B?TDdpeEpEb1lPNWs5WlVXR2Z6MlN2WWpuTHMveVNFdmFHSi91Sm5waVRwSStp?=
 =?utf-8?B?UlFDK01ydmFOcXBRaDZzNHVLU2RwWjhQa05Fb3pPcnJTSjAwd2RCRHRydTB0?=
 =?utf-8?B?a0x4dllHV2xPbDVFeXhIR2IrL3dSMDZyOUJoZGlrUGs4cDJjNmowWVR3cWdE?=
 =?utf-8?B?UHdTV2tGdGlkV3RHNGZjbW5uWFVRWTdBd0VVbFZGSXFwd2VBRVFVbFZiYmtj?=
 =?utf-8?B?TWUyb1NsUlNhTENKeWQvZGQzeU5MMDZTSk9PSmRVY1hvMTJrMUNyRU8wM3Nz?=
 =?utf-8?Q?mMsYLftr8AHjlrrhqBpfgox1gygodKAuYGqd2FgN0bL8L?=
X-MS-Exchange-AntiSpam-MessageData-1: 2UGJwpSCIek0Mg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c3da22-aa2b-45ed-2d28-08df3493b8dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 01:35:17.8118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZ5C0+FQGsGKY8LAV43/GLTackJyk5SJ3X78n+oujvEADgH9Ih9Of6SxRhVXzjEisGELAbhkwYRBLfXF2NOjCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sunday, October 25, 2026 5:51=E2=80=AFPM Svyatoslav Ryhel wrote:
> =D0=BD=D0=B4, 25 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 03=
:46 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Friday, October 23, 2026 11:14=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > =D0=BF=D1=82, 23 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 11:26 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > =D0=BF=D1=82, 23 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 10:53 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > ...
> > > > > > +MODULE_ALIAS("platform:tegra-dbi");
> > > > > > +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > > > > > +MODULE_DESCRIPTION("Nvidia Tegra20/30 MIPI-DBI Type B driver")=
;
> > > > > > +MODULE_LICENSE("GPL");
> > > > >
> > > > > No separate platform driver or device. If a separate struct devic=
e is
> > > > > needed for some technical purpose, we need to create a minimal se=
parate
> > > > > virtual device, but unless there is a strong reason to have that =
we
> > > > > should be fine with just the dc device.
> > > > >
> > > > > Thank you
> > > > > Mikko
> > > > >
> > > >
> > > > ATM, I use bridge framework to describe interface and I am attachin=
g
> > > > it to RGB since it basically uses RGB to transfer video data. It wo=
rks
> > > > pretty nice so far.
> > > >
> > > > You propose to replicate how RGB works just for DBI?
> > > >
> > >
> > > One of the reasons I used separate pdev was to be able get mipi_dbi
> > > from it using dev_get_drvdata() from patent (dbi bridge in this case)=
.
> > > DBI framework seems to not have a way to pass it in any other way,
> > > unless you know smth I don't.
> >
> > Right, I think using a bridge is fine; passing the mipi_dbi interface i=
s
> > properly done in other ways. The direct parent devdata link is a bit of
> > a "poor man's bus", and sometimes it breaks down, such as here.
> >
> > MIPI DBI is comparable to MIPI DSI -- both have a hardware channel that
> > sends both pixel data and commands. I think we should follow DSI's
> > example and have a DBI bus and devices while keeping it as simple as
> > possible.
> >
> > The DC driver would register a DBI host and the panel would bind as a
> > DBI device. The DC driver can then supply the mipi_dbi object in a fiel=
d
> > of the mipi_dbi_device.
> >
> > This is a bit more complicated than a parent devdata pointer but much
> > cleaner, and follows the existing DSI pattern.
> >
>=20
> I understand your intentions, but ATM kernel lacks any DBI type B
> framework. No hosts, ho devices, noting granular. Implementing
> everything just not worth my time to support 2 panels of device based
> on Tegra 20. And I am talking not about time to actually implement
> this in the code, but to upstream. DSI framework is huge, copying even
> part of it to wrap legacy DBI interface and ustreaming it does not
> worth hassle. And yes, I am a poor man, I use a parent devdata bus.

I sketched out the bus implementation and I really don't think it's that=20
complicated -- about 200 lines in total. See below. If there turn out to=20
be issues we can put an equivalent into drm/tegra/.

-- drm_mipi_dbi_bus.c

/* MIPI DBI devices with command transport through parallel interface */

#include <linux/err.h>
#include <linux/init.h>
#include <linux/of.h>
#include <linux/of_device.h>
#include <linux/slab.h>

#include <drm/drm_mipi_dbi.h>
#include <drm/drm_mipi_dbi_bus.h>

static int mipi_dbi_match(struct device *dev, const struct device_driver *d=
river)
{
        return of_driver_match_device(dev, driver);
}

static int mipi_dbi_uevent(const struct device *dev, struct kobj_uevent_env=
 *env)
{
        return of_device_uevent_modalias(dev, env);
}

static const struct bus_type mipi_dbi_bus_type =3D {
        .name =3D "mipi-dbi",
        .match =3D mipi_dbi_match,
        .uevent =3D mipi_dbi_uevent,
};

static void mipi_dbi_device_release(struct device *dev)
{
        of_node_put(dev->of_node);
        kfree(to_mipi_dbi_device(dev));
}

static void mipi_dbi_device_unregister(void *data)
{
        struct device *dev =3D data;

        of_node_clear_flag(dev->of_node, OF_POPULATED);
        device_unregister(dev);
}

/* called by dbi host driver to create panel device */
struct mipi_dbi_device *
devm_mipi_dbi_device_register(struct mipi_dbi_host *host, struct device_nod=
e *np)
{
        struct mipi_dbi_device *dbidev;
        int ret;

        if (!host || !host->dev || !host->dbi || !host->dbi->command ||
            !host->ops || !host->ops->attach || !host->ops->detach || !np)
                return ERR_PTR(-EINVAL);

        if (!of_device_is_available(np))
                return ERR_PTR(-ENODEV);

        dbidev =3D kzalloc_obj(*dbidev);
        if (!dbidev)
                return ERR_PTR(-ENOMEM);

        if (of_node_test_and_set_flag(np, OF_POPULATED)) {
                kfree(dbidev);
                return ERR_PTR(-EBUSY);
        }

        dbidev->host =3D host;
        dbidev->dbi =3D host->dbi;
        device_initialize(&dbidev->dev);
        dbidev->dev.parent =3D host->dev;
        dbidev->dev.bus =3D &mipi_dbi_bus_type;
        dbidev->dev.release =3D mipi_dbi_device_release;
        device_set_node(&dbidev->dev, of_fwnode_handle(of_node_get(np)));

        ret =3D dev_set_name(&dbidev->dev, "%s:%s", dev_name(host->dev), np=
->full_name);
        if (ret)
                goto put_device;

        ret =3D device_add(&dbidev->dev);
        if (ret)
                goto put_device;

        ret =3D devm_add_action_or_reset(host->dev, mipi_dbi_device_unregis=
ter,
                                       &dbidev->dev);
        if (ret)
                return ERR_PTR(ret);

        return dbidev;

put_device:
        of_node_clear_flag(np, OF_POPULATED);
        put_device(&dbidev->dev);
        return ERR_PTR(ret);
}
EXPORT_SYMBOL_GPL(devm_mipi_dbi_device_register);

static void mipi_dbi_detach(void *data)
{
        struct mipi_dbi_device *dev =3D data;

        dev->host->ops->detach(dev->host, dev);
        dev->attached =3D false;
}

/* called by panel on probe completion to attach to dbi host */
int devm_mipi_dbi_attach(struct mipi_dbi_device *dev)
{
        int ret;

        if (dev->attached)
                return -EBUSY;

        ret =3D dev->host->ops->attach(dev->host, dev);
        if (ret)
                return ret;

        dev->attached =3D true;
        return devm_add_action_or_reset(&dev->dev, mipi_dbi_detach, dev);
}
EXPORT_SYMBOL_GPL(devm_mipi_dbi_attach);

int __mipi_dbi_driver_register(struct device_driver *driver, struct module =
*owner)
{
        driver->owner =3D owner;
        driver->bus =3D &mipi_dbi_bus_type;

        return driver_register(driver);
}
EXPORT_SYMBOL_GPL(__mipi_dbi_driver_register);

void mipi_dbi_driver_unregister(struct device_driver *driver)
{
        driver_unregister(driver);
}
EXPORT_SYMBOL_GPL(mipi_dbi_driver_unregister);

static int __init mipi_dbi_bus_init(void)
{
        return bus_register(&mipi_dbi_bus_type);
}
subsys_initcall(mipi_dbi_bus_init);

static void __exit mipi_dbi_bus_exit(void)
{
        bus_unregister(&mipi_dbi_bus_type);
}
module_exit(mipi_dbi_bus_exit);

-- drm_mipi_dbi_bus.h

#ifndef __DRM_MIPI_DBI_BUS_H__
#define __DRM_MIPI_DBI_BUS_H__

#include <linux/device.h>
#include <linux/module.h>

struct device_node;
struct mipi_dbi;
struct mipi_dbi_device;
struct mipi_dbi_host;

struct mipi_dbi_host_ops {
        int (*attach)(struct mipi_dbi_host *host, struct mipi_dbi_device *d=
ev);
        void (*detach)(struct mipi_dbi_host *host, struct mipi_dbi_device *=
dev);
};

struct mipi_dbi_host {
        struct device *dev;
        struct mipi_dbi *dbi;
        const struct mipi_dbi_host_ops *ops;
};

struct mipi_dbi_device {
        struct device dev;
        struct mipi_dbi *dbi;
        struct mipi_dbi_host *host;
        bool attached;
};

static inline struct mipi_dbi_device *to_mipi_dbi_device(struct device *dev=
)
{
        return container_of(dev, struct mipi_dbi_device, dev);
}

struct mipi_dbi_device *
devm_mipi_dbi_device_register(struct mipi_dbi_host *host, struct device_nod=
e *np);
int devm_mipi_dbi_attach(struct mipi_dbi_device *dev);

int __mipi_dbi_driver_register(struct device_driver *driver, struct module =
*owner);
void mipi_dbi_driver_unregister(struct device_driver *driver);

#define mipi_dbi_driver_register(driver) \
        __mipi_dbi_driver_register(driver, THIS_MODULE)

#define module_mipi_dbi_driver(driver) \
        module_driver(driver, mipi_dbi_driver_register, mipi_dbi_driver_unr=
egister)

#endif




