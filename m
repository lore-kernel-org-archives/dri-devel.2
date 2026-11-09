Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C8606A330
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RcW+NRuh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE5A10ED27;
	Mon,  9 Nov 2026 02:39:15 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8092F10ED27
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 02:39:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPxhw0aAu1HTCakqPafaM57JAEh+276m+6VyF/HB27ibpCBlR78XDx90Q563lICVzfc2QKZ8JLG8FzZ+Ve6feEodj4r8j2CDk1Q1R6Q/Drmsfuylh9l+adL/Aq/c8CND8WFRQDJJY4AXweOEXf/inXYDZRC+ezYOjXJZwOxxXGi04vpvHkl801vYZEtmSZUqNRe5vJnpDah9fND9j5NcAlqXwoMFl/WmMGI/5WvcIs+G2AzRmaeE6KX9oy2Q752JalQDGgfjStX19oNURYD3P4y4LeVFJ6CV0zXwrptY/tqWjGAdvLVUGIDuokMGKEb3mXhsfdav5EsfYafd7Mwaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vETqnw6JkuoXbH9f8kankYKi/3tKoS0MH6pDi8u+gIA=;
 b=r3v6JrDsmyJPprPJFvifl3wXU2bsECxdTp7PDDOYpCvooMypwojbUQcnhm2lv6XtAVTPE3D8kJAWgBThhYUlJJQjZqnmzcW/dQydYMXd3ydkzvFbeSwrNxP9Bhc7vzeNqveJme753QHk09wWZTLZVaxE/PaJ3iyQ9rjoehwscK2dgEYuhvpDOIVA/Y56ACqshFd0W02a4twwRdcYTmVW25ETZbmWokMbU6+WXi/AV46+6Rtjr57gNwebhfY2oqvjbA9bXblD+bYWzeztSEbD9+/p9hpEDdqBgwsFpPlNHffdeuuSOL19vP8XgZTlr4SULZj7WjHndjFBy8LwyvpyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vETqnw6JkuoXbH9f8kankYKi/3tKoS0MH6pDi8u+gIA=;
 b=RcW+NRuhNQbGtFAnkVhumMaAl+saIEwOmiwPEHi0botkWR0ygZvnMqOM/2d5mlbbGauBL44yo4L0L9I3SugkyU2ldhaFJoht4fDrCfKYTH/cvGcMcRLhXXzNdPHks7KbmXaEOth1CLNikj3f8C3YGHrAQwYBbU82Nf8yidTJ8ra6AyFOx/6/I4ld/LU9xTOurvynId02zNkDiBh7dVh7Bb29NZC/+P54vsrd+2GTID41NQJC6nhm60/yRYHmRfOalq1AwfDEfd9DMvl9uG9kyeR9RPW1NEhgdPpbEG4xMWAb6gCsXISkOOEuzZJZ5khigqnbNnD7UM+DljgHlWsKyA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SAWPR12MB999116.namprd12.prod.outlook.com (2603:10b6:806:4e4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 02:39:04 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 02:39:04 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, devicetree@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH v6 09/10] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Date: Mon, 09 Nov 2026 11:38:07 +0900
Message-ID: <WCkIU6FiT8uFearoaeYKdA@nvidia.com>
In-Reply-To: <au33NIR4bCAkokJH@orome>
References: <20261105140510.165165-1-clamor95@gmail.com>
 <CAPVz0n1j0M1Zjj90pEGCYiNqUQv00N89oPcAxZbA7upuxhoF9w@mail.gmail.com>
 <au33NIR4bCAkokJH@orome>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::6) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SAWPR12MB999116:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d58958-13d1-4148-164a-08df3e0a9e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|10067099003|5023799004|11063799006|4143699003|56012099006|261021121427099003|261021135927099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: cA21XAoFRoSahWUhf7+cuiGY8fLe0w9N/mvJALha73wD/EyUG9yv5MpwpkQ3gcMVVHlroYB6ZwX/q7qpOJjy0eZ2MQ5uozUo0W64wNIoCoBrGkmgfK1c8ZoHHN2459bFFgSjonUlWu+iedBvBrEbsQkIF382qeguy9+TysFwJvHqKFG6PoyBHxNDpAqxXjAro6mAxscXBYGHzsy0xKbrrDW8ok5Pzldy2/CV9TBIPrimsknjbawwymeYD72RHBFT0cSLD/UKbgD9dMDEL/dJgOJFwbEHe5M6Sll10t4OnXfHY+scyVgE/KC+pEZg6GbvQ1VcPNM0VHRAKz3zQXSHweVxXfF1wqY9fxalCq4ztJm0yFXrAYD4iw//f8bXFEsEvP+tZ4scdxkapk9KVXprHgud4CBbjTp+SV+NnyGHgsxpCxfEYzUfMjMGwORu1snRxgpomdAbmuWRV8yui01aPbf7CEvbyObKhkw2w5j83kmNv0V9dKNCsthaLUIC4/INDMiiulci2fcKTcPvskVf+zs9NVW8DpMvh6DYbk+GpQg2ngS8H/XJzY9/UwxQBqL4BnBUWafbpPNleNYn8+oRDkUj9xU79iUHLwVbZiOjyNH3Bfbm9pI2SIObTOloYOTKBc8kUMQFjryV6iGYwgtpyV54j/iwtSUOFXhZPaJuL5c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021135927099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1VkN3R0aFVjVlpDRUNoMmk2Qzk0UlkzdXpPY3daVTZnM3lhTjhHMWpiMk1D?=
 =?utf-8?B?TFpVZGc5Q09McVJ0UHhjTGh3bExudjBJSWw4R3VpVG9ZY1kwVUxDZEV2Ly9O?=
 =?utf-8?B?NUxMWVF6U2tSam9aVGRtdCtyN1JkNmdVM3NoZ1lBZWYrdElOYXVrYkd3cVdw?=
 =?utf-8?B?ZisxS1hJZTdMWE4rVkk2UUlOd0o2RHd6Z3RReXR1emhrRDcrWDB3dUQxbG1E?=
 =?utf-8?B?ODc1QW9NUHBZdVd0L2JPL2hZUUJRaTJTWlpvSzJtTFkxNDhMYjhXMUlVQmdJ?=
 =?utf-8?B?YUsvY3Y2dkRlQ2RZcHdYY0xUSFhCWldKYnRUTGFuRjhMY3h6ZjdXZ3pKQXV0?=
 =?utf-8?B?SDNYVnk2R2h2LzgvNUdzaUpLVjZaUnJCUXkrYXdBT05LUkg2eGJUQWp2Und0?=
 =?utf-8?B?d1hzajk0OEJhWjkrWFFSY3dlU3E3eW5UVXhYQUttQnErNTVXbjhCVWRCbDlq?=
 =?utf-8?B?WUptYWV5SEY2NEYySVk2VFBmN1lMNzFUaUNSMHQyS0Q3ZkI1ZXZPNStubFNo?=
 =?utf-8?B?U25tZ2ZpZ1pQcTJQOVY3ckFuaTU4cUN2SDhyZVhtYW1kdk52b011WWx0SVgx?=
 =?utf-8?B?UTVSSDlOWHkwWW8vSDgrVVQ0cnhYNVhDSGJkdXdrK24yVGo2RzVVTFIyYi9R?=
 =?utf-8?B?Y1VlVVB6K2ZLeW5lcTJqK1B5NmFSMlhtN0lnWWZZd3dmd2dKclpyMTBsUVRW?=
 =?utf-8?B?Rzk4SUovc1M5ZGUwNVoyMHNDZW9RY29GTVNTWkczbjB4bU9lQ2sydHpTUnpR?=
 =?utf-8?B?YWdLTG5ETmRTTzFLeE5COUtmUzRyM1VHeCtZdWt5M0xMSFBpSnNuY2svbjhV?=
 =?utf-8?B?aUIzZzhCRUFCMWRpV0k5bW1xbGFtUUNKbGRSQkt5WnpZOXljOXBLZ1pDL0ZW?=
 =?utf-8?B?TUMza0JiWEI3clhpNlJHNTdhdXd5K3BTZnNQNGZRTDZYNWU2UjdacHVQV1hy?=
 =?utf-8?B?M3pjQnFkSmZROWZMUGd6WmxSUkROQUVNUytOMzdSMDdEZGdkOHpuMkVQL2ho?=
 =?utf-8?B?NzlrZ2g4Y2RqL0NxTFZDRUk2NzhuSGd6M21EYVFrRFBuUVJwSzVRSUpIZThi?=
 =?utf-8?B?U3NxY3RmNDNrRVg2RTkyWUNOWFZjQ1RnSFIrMmZkdlBUb0xSQW96OGRoWVkz?=
 =?utf-8?B?cXhJRkJtL0JtdS93WXQxK3l2Rys1T3VRUHY2RDNadGN6N215SEdOVkxJWEpw?=
 =?utf-8?B?SXBlMUl0Y2M1YXQrWUdydUFhL2NCNkNFdU5TbVF3ZDQ4R3hQMmdSN1paczhz?=
 =?utf-8?B?MnB1QS9MM0VwVms4dW5BdHB6dGs4SkF0UFpvbmNodUFrOGVaNkF4eGtRZFl0?=
 =?utf-8?B?M2dKc3d6Q3lBejZQeDRtN2g1SkJ4bHF1RXRGQ0Z0Y1VZc2g3K01IMlA3Q1Ju?=
 =?utf-8?B?YmlDZkRjTS9GQVE3V0Z5Ykg4TzhnK3JBeU9adU1SeStkdVhnZ0hmWEN6RVJZ?=
 =?utf-8?B?VFVZQlBqR0w2dkVmM1RZTURrNmVKYkQyYW9vZnhYeEhvNjliM2JXdGhPVFN5?=
 =?utf-8?B?OVJLanB6OFpCMzRoeHFrclNQU0FBM3gyc2dwUzVDRDFkd3pmekNoKzVUSmVi?=
 =?utf-8?B?cHZ6Nk4reFdEZndFNlJYRjBRdTAxdVV2amJyOHplTlQzelRDb21ZNmRCY0J0?=
 =?utf-8?B?WlloMTlVeUNYZUtvZVlSdC9MYlg4dTlBOGE3Qm9hUXlrellJckNsVXR4NlN6?=
 =?utf-8?B?aUl5SThidm1tS2ZiMjlBSmxvTTk2bkQvakNyNi9ZSXI4V0thdURKWEpPTHdD?=
 =?utf-8?B?RUpaSm0vWmhGekxoMlg2U3l4K2VST2RtdVh6RURWdkkzZGM1bkVqOVhkUEZB?=
 =?utf-8?B?K3o2cWVyamNjOFgzUkVpLzdmWTQ5Y3JJTzQwNXVNa1Z2MXVWdFdvY3lsOStv?=
 =?utf-8?B?SUhYTy95ZHVVN2ZjQ25zT2kvQXl6RFppNHZQOTc1OUpxMnlTZzE5OUZIeGxL?=
 =?utf-8?B?M09JTms3R0FNa3ZaVTIwYStHMUZtQ0tLdEx1N1hoWVkxcnlFMVFkWVZWUUpq?=
 =?utf-8?B?Z1hXZllrRVFib1RVdTlCMWxlYnRhU1A5Z1hXeGFxbG1jM1dnZzAzV1o5bHV4?=
 =?utf-8?B?VW5xTi9CQ1FpVFVmL05TdjJGYVljNkVZUXZvdWhvODlGclNyN3FUUHRYZmhi?=
 =?utf-8?B?SHdpYTVQa09Rb3BaaVJ4eG9qK2NXQTYvZUNvQVIvS0FGN3hOaG82MlpFcDUz?=
 =?utf-8?B?OHJQZkNBN1BvQjdZWktRdkk2RXMwaVhobjRIYUUrWUx2Mm5lUmhhNkFaSFpJ?=
 =?utf-8?B?VXYzSzFGQTNlUmpEMHRTQzRQOGlZOGg4ZEV4a2ZjeURaQ09SelRLRzBOWWV4?=
 =?utf-8?B?dzBOdFdkTTRzdjUzYUhxTzVXM3dwWnVwMFZBN3JJZDJ0VXZ5aXdqSTl0eXdz?=
 =?utf-8?Q?w52XzpOU5MPg6nTwavC+th947v+u9hLL6E90BAN6Ne+uD?=
X-MS-Exchange-AntiSpam-MessageData-1: BA4Iw+p+SLNF0Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d58958-13d1-4148-164a-08df3e0a9e61
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 02:39:03.9853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jog4meiHHmcbY4bwwGw2V5UmJOiy7AiEaPviQdx9S9XyK3vJoogcsdPBxOpHwtzjM32S7/3Vv0cpZpk2eJKFzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999116
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

On Saturday, November 7, 2026 12:51=E2=80=AFAM Thierry Reding wrote:
> On Fri, Nov 06, 2026 at 04:48:17PM +0200, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 1=
6:40 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Fri, Nov 06, 2026 at 04:11:12PM +0200, Svyatoslav Ryhel wrote:
> > > > =D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 16:08 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=
=B5:
> > > > >
> > > > > On Thu, Nov 05, 2026 at 04:05:09PM +0200, Svyatoslav Ryhel wrote:
> > > > > > Document 8-bit CPU parallel MIPI DBI Type B interface provided =
by
> > > > > > Tegra20/30 SoCs display controller.
> > > > > >
> > > > > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > ---
> > > > > >  .../display/tegra/nvidia,tegra20-dbi.yaml     | 113 ++++++++++=
++++++++
> > > > > >  .../display/tegra/nvidia,tegra20-dc.yaml      |  22 ++++
> > > > > >  2 files changed, 135 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/display/t=
egra/nvidia,tegra20-dbi.yaml
> > > > > >
> > > > > [...]
> > > > > > diff --git a/Documentation/devicetree/bindings/display/tegra/nv=
idia,tegra20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvid=
ia,tegra20-dc.yaml
> > > > > > index 69be95afd5627..ffeb124905dbf 100644
> > > > > > --- a/Documentation/devicetree/bindings/display/tegra/nvidia,te=
gra20-dc.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,te=
gra20-dc.yaml
> > > > > > @@ -79,6 +79,16 @@ properties:
> > > > > >    rgb:
> > > > > >      type: object
> > > > > >
> > > > > > +  "#address-cells":
> > > > > > +    const: 1
> > > > > > +
> > > > > > +  "#size-cells":
> > > > > > +    const: 0
> > > > > > +
> > > > > > +patternProperties:
> > > > > > +  "^dbi@[0-1]$":
> > > > > > +    $ref: /schemas/display/tegra/nvidia,tegra20-dbi.yaml#
> > > > >
> > > > > I think it might be better to group these under a separate dbi no=
de at
> > > > > the top-level, making it a sibling to the "rgb" node. If you add
> > > > > #address-cells and #size-cells here, I think that means technical=
ly the
> > > > > "rgb" is now in the same address space as those new dbi nodes and=
 would
> > > > > need its own "reg" property and such.
> > > > >
> > > >
> > > > Only 1 DBI node per DC is available. Adding address/size cells mean=
s
> > > > nothing for rgb.
> > >
> > > If only one node is available, then "reg" isn't the right property.
> > > "reg" indicates we're somehow addressing the child, which applies to =
all
> > > children, so I don't think that would work here. A separate property
> > > would make more sense in that case.
> > >
> >=20
> > Check v5 and talk to Mikko
>=20
> I checked v5. I disagree.
>=20
> Thierry

My mistake; if there's only one node per DC then reg isn't the right=20
property.

Mikko



