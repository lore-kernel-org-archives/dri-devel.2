Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5B6CDE006
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E5EB10F1CA;
	Thu, 25 Jun 2026 09:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZOE/r9uU";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1F1A10F1C5
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:27:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMTF4G16lVpi8BmVAVIBxCEEvA1XkBz/rqDgiER1Q3oTECKCaxn6Ix32CrzsjwLUiKwxquMOVdzzvlWv0q/vqq68SgZPYwud9wnMhPVlcKS4PuVJo9IXh5JM8AlOC2LU5qWNx5yfC3nhSak13x6ihrW+VhZXWrmW/94GNxa1seK0Srehwo3vhKjgoMDc+GU9uPzR3NUHmt4Cfi2/gj4Lo8RZwHjybueNbqZ3zs8vlCZtFdqtLAXHrbLeQDIWB3wvpDVskfMv/424fCHwD45zWsoY6TW5aTRcdAq8zuiY6a42E+gWv8vQIDhaWv8P0N+AR9ykACZCJMTevr/ooSwk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYspXsYu+OTTHQz46D8JnC9xquNSvlZ0gpTC9ahzl+I=;
 b=ZpzMDlD0/d4Mjt8tj89h5qUQnbCLZRv/Xc2e7kg+gz1hYmZjt/GS7pM59oKfNkMedRz2hlxHKbBK0wVznDJP0NVngoJvtb79qWLWazA4eLMRAsSZPNKmuiViFX9afiF5LTVcyvcQFRph3h9inukwppa0t/AzTsesgqowfeYKms1ZKyAsDpLEr/cEMxGUI/nCA3m7A0myp138Q4M35kuz81cA4Ou1JRlPyK0UA2SK00W97h9JboJK9IpUjWf3XfRoyIUfKvDVLjBgF2/dhNCQsyruHwmj5o/ZZ4SNGcwLF1D1sx2/NNSnZwd6Sred1SAKQoGO6uHVW/W/vx6qeKOXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYspXsYu+OTTHQz46D8JnC9xquNSvlZ0gpTC9ahzl+I=;
 b=ZOE/r9uUGDT56D5b86+CAgKnl3gZJ4RG92QM8HYC7jxUlRCsaSLURzyv7R3A4j/+IqGGA/7yb2KccJTajU89KAiq7D65GoBCWF1HYyOFW8uZQCiC2ynG/9u31A6ntaLS7ZALjeVqwW3/rkwjP7cwE/uAw/jNI8A4iylfjdeCWpqcsI+i7Yz5CuTEk2ZsP1zLxMN0m1Ri/PcAMWn153+CPKWD2tJIuonexYxBt0Oqynj3cr944dFZ/jjgpUdQydPEVm4fDBAm5t8bWWj/T/2P/+K0mwVk0w34/YdNyigQH0RMqCsT6gA8AzDFxBMLy0vPw7NqExF+H9jyfbmShTmSQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 09:27:00 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 09:27:00 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: display: tegra: Add channel/syncpoint
 range properties
Date: Thu, 25 Jun 2026 18:26:43 +0900
Message-ID: <Np88My8kTE-rRphOw0a-Ew@nvidia.com>
In-Reply-To: <20260625-poetic-heavy-vulture-7baabb@quoll>
References: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
 <20260622-host1x-nohv-v1-2-65bc682a617f@nvidia.com>
 <20260625-poetic-heavy-vulture-7baabb@quoll>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P286CA0056.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ1PR12MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: d39e1f3e-cb13-4a92-6b6d-08ded29be8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: kf8PoRoSlL8CtxOwwyp0i8jFMFiLSKza00FtZv4JVqHKVYw/0FK5vZJANvxuyPk5a9ciqPlhpAvkFgc8NdqfuGUbtfHgGjXomFWjYPIo2Xfn4U4W8cwCkuipj+Guwqe/OL7eQAmbWZ+vEMcjWFInb5jkqr2JITS0M4GGL0rqyvLbBVYv8uykvI17bL9fni8HIOKK8FwONTjKQ5cyHX4dDUnl2ImKfK6/WVS7WKE58gRW28/Va4L8wM3KH9rtrEdAk3t79iWeI8acPn9w1BsWH2DvR26KrSBe2M164LDO2Q+lSJ8ohe8wyqghk6NbmxZ5NUKdx+7nNH6JBZw7+HDBEdkmvgqJCM3OQGJCHps5aQUObsR6SRXG0m5Hp/MWQXBqztJLrZMODDML8stvWPIjp2hRw+UCIMF7PHzQjfbMbSu99YiyiQ3C8pY9DVmuzTqrkyHGKyb+mToQk1KnHquI3YOM6+tiUzlwAgLzMTdNXETAGuq3OH38BrKsYVCNGDwNDdBfNbVEreLz3iAH8sY0JhtuU/NyCaeZqtCxKWOo6l8DFmx8wqOBhe+IUL454BpTWZFQkUCf2N46GvzpuK+N9PzftkqGsbD+lQsHRVNOrZeqTognVc0ic2kwX6OsU+QWEMEp8XwCHFhI/Em+YTcJ8BEaVbSbo6xC4up3P2ExLYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3pvSi84OXhDTitENkd3ZXR0RUV0QXB1UXlWS0prMFJQMHZXckFzSUhPcVFh?=
 =?utf-8?B?b0hKMjhZWWh1ajhVMERVZ1RWYWFZUDY0Zjd5d2plVXpUTUd0ZFkvS213Uktl?=
 =?utf-8?B?WlJTK0JQM3BHcHRCNzZLTmdUTUR0QzZZSWdydTc1VXc5MnlLZ1FLU2xxMWxE?=
 =?utf-8?B?Qk40a0dPUFZDUnFRMm1Sb05JNlZFMDN4VXFXTVRqeU9RR3dkQkNnUFIvd1pk?=
 =?utf-8?B?ejRXUDZUVnpoZng2TktYTVlzZDhNUTNISkVOWkRsZXp6WmdFSWVIdDIzNzBx?=
 =?utf-8?B?aFo5akl0dmpNaFNwWXlVZW5SOWhpdmo3VnpxSXQ4RnAxZS82SmpWc29qMnUv?=
 =?utf-8?B?cWhVcThUQ1dUcy9HenJxK1FER2RHblVCVWV1Y0V3UlRmNk9GWXg0YlJhZHdY?=
 =?utf-8?B?MWlWMVZHem95STNTcGxPU2lqZWhYaWJ0ZlgvNlE5TGl1eTBUZ3M1aHBEL2Qz?=
 =?utf-8?B?Qjh5dWJzUG9mdUYyTDYrNmlWQ0N1TG8rVlduSmhZcG5sU0IxOE5WdUo5MWps?=
 =?utf-8?B?Q2tySVZ1K0JPdnpKb05YN2ZDWVU5TkZqd3BFUStSRm02YnE1ZGZmd2Fldk9B?=
 =?utf-8?B?T3hXelhRSHNUU3Z6VUxHcmF0WEZjMTl6cTlSTGQySmNkTXUvdUYzRlVZMzFw?=
 =?utf-8?B?T2lteERPQk1vVUx2MHpnTzVYbjdJdTdCL24zcGoyWWpRME16S3FaWmMvTG1R?=
 =?utf-8?B?Z2c3UHFuYk9vK1QzT2x5ekY3MFJGSkptSFAyY2VFaW1xWjd2S0F1Qkk4NTlL?=
 =?utf-8?B?R3NnYVgrQXhBT0gxZk96c0tJTEU3Uy9FRTFYQXBQaDJicytTZmNaTUZoRmR3?=
 =?utf-8?B?Mk4zTEg2MlFNeXhWRllyRVhCeFBHdlYyUktQL1pZNHJ3Rm9jbFdvbFVDdVdH?=
 =?utf-8?B?M093VzhDUDZybXlyRWlwUFdvTEkxb2ZBelJxak5pYXRGZDcyY2syMm53Q3l5?=
 =?utf-8?B?Y0w0TFgwSXdWTXVLTEV3d0ZMdXMzVkhqcmFKblFiU2RIemdJdGg0Y0k1Uzlx?=
 =?utf-8?B?dkM1NlFQQUZUdHRKMDN3VzRpQUNRUXA4ZzFUVFl0cDJVMWV1aTgzNkFob0lH?=
 =?utf-8?B?bHF1WHZINmlMcmd1R2pzL3Z0amE4NmtIa0JWZmd5dldtZFVocFZLWFc0VlRP?=
 =?utf-8?B?UWFnWlhmR0xwSkEraURxMnRGM0JkenJTRXZpOHJzOXpuemNkZDNlTzhXU0t6?=
 =?utf-8?B?Y05veFlPV3JtZ0ZmUGhuWVVZZlB1MGRPdXR2aVRreWF2dVBZVFIySjFyc3Y0?=
 =?utf-8?B?TTI3bXZ5dkZaV2FsU1Y0ZGtmT3dqRUgvNjdsQkZZVENUbzJpcXY1Zi9mOGdS?=
 =?utf-8?B?N0h1NHRtQjNPWHU3MFVYK1lQR1hWOG9ZRXJvYWF6K0JhRkk3emUyVXhGcmQr?=
 =?utf-8?B?cUZ4RnFZVzgzRkdiUjlQUCtabXNUMWtUY3RUZ2M4STZtL1pQT0c1QnZOdkl2?=
 =?utf-8?B?b1VsNlNxUUZYTVFQNHpJUHkvdkNsOWhoZDEvMHFLVFRldy81WWlVa05sQldH?=
 =?utf-8?B?OGhlMkd6OHY5Ykl1clJ6WElyNDV0bldVRFRsbzVhRmxpcmR1dHQzOTRROVBM?=
 =?utf-8?B?ODlQNjUxdW1XL3VlNFgrZzlHNEM2UmtXOE15N1V0eml2T2lSSDJvaDVPNEJM?=
 =?utf-8?B?UjFwaHU4N01LZFZtT09mcDNtbGRNK09udEpZcDJmc3h4eS9YRHFmMXdXTVJz?=
 =?utf-8?B?WjJkVHFJS3laRTA3Zm5RU1JTeGVwT3N1Zk96azYxWjVlVWxOaWVHVk1YNFZI?=
 =?utf-8?B?ZU1oaDR5R3JFRW03aFBxYkthcnppSXhkK1A2QktZd3VCYTM4aXdqVmc0d29i?=
 =?utf-8?B?SFdNZFRQOU5CU01NR1ByTVFoN21rTlE4OUpIZkpEQjVBc05FR3pCRVQ0bzBO?=
 =?utf-8?B?KzhyRFpOQ2MwM2U5RmVsZ0V4QVo0YTQ2V1ZvVlJZWEtSTjI0UUF3ci9mcy9w?=
 =?utf-8?B?TmFGTjFUNjZtNWZ4UWI2dlNESmdnZ1A0eWZnekhPTU1rb2pwRzBSSkl6TmJZ?=
 =?utf-8?B?ZHVEZ3lDZFlFa1hCRFdxQ052Vnl0ekhub3VNNTI2b1VFemlmRWloc2w0bDZw?=
 =?utf-8?B?Nmw1UzdUWThXWnpISzVYOGg3WlNLKzZwVWlVUUFGYmVzYkl5WEF3V2JqaVF6?=
 =?utf-8?B?cUtzNkpDSks4ekRjSU9lUDNSS0ZTTThRR25oWWtiMllzaU9ibVFlRmJOSWFx?=
 =?utf-8?B?ZzNqOFRnMWpWM05TZ2huck51WFJjQ0QwU0EwRU45cENvWm5CMGJ1UWJTZlRn?=
 =?utf-8?B?QlhBV0FrL3NkSUk3Mkl4T3VPSWwrOHRXeXBQbW8xUHQ1U2N3M0d1d2tOWVNk?=
 =?utf-8?B?OVZzaUFiWkFKSjBmYXlPelNmT0pqZHUxT1VlUWFBb1NvRFRmU1BQYjhwMERO?=
 =?utf-8?Q?V/on5Mwb3DrxtimPTdIuRP5ZDsh2YyOG5CgWI1JODGLZ6?=
X-MS-Exchange-AntiSpam-MessageData-1: dN0UF3bdi47W3g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39e1f3e-cb13-4a92-6b6d-08ded29be8ae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 09:26:59.9618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBHFoFW7dOoEwJrKRlSCNgDuwy55ZdwX+0MWPO5IBDLxHxeaEMpKKTzGqUeJUws73dsAkrfoavT0gPBdJMQ+BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6194
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

On Thursday, June 25, 2026 5:36=E2=80=AFPM Krzysztof Kozlowski wrote:
> On Mon, Jun 22, 2026 at 05:22:51PM +0900, Mikko Perttunen wrote:
> > Channels and syncpoints available may be limited when other system
>=20
> What are channels and syncpoints?

Very host1x-specific hardware resources. Somewhat close to GPU channels
and semaphores / fences if you're familiar with those.

>=20
> > components are using them. Add properties nvidia,channels and
> > nvidia,syncpoints to limit the range of usable channels and/or
> > syncpoints.
>=20
> Why isn't this deducible from the compatible?

When Host1x is partitioned, the hypervisor (or other software entity
with access to the non-vm host1x register regions) can configure which
channels and syncpoints are available to each partition arbitrarily.

How that partitioning was done is not discoverable through hardware
directly, so we need to pass that information through device tree.

>=20
> Also, nvidia,channels is too broad/generic. This is not ADC, right? And
> channels is a common term in IIO. And in few other cases.

It's not ADC. Yes, it's a common term in a lot of contexts. I can call
it nvidia,host1x-channels if you prefer but that seems a bit redundant
given the context.

>=20
> Best regards,
> Krzysztof
>=20
>=20

Thank you
Mikko





