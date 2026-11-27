Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D56606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ADm3X3H1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A65210E3FF;
	Fri, 27 Nov 2026 06:57:07 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 266A110E400
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 06:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIvamcIzGowZ2OXJzF7Qekmyvdmpb4GPdd/NNYjTIwiiCJC0BxaI3+YpUP3VoK9NWWDsN35Sc8DgoDCNDAZgQHslnAGYC1B6bJFUbxykfzOl0jQzRmHf+A0E5JfObKlbDRmmnbinTQHx+KUkKDLJU18mVSYYMHDlDBsNigXKulD4MKVOcMXS9azL8bTV/Msd+sUzdkhMiobQnaYet9INgLxBy36N6TgD3UCUHlspl/LWu55zI9QHsfwL56xc4KGapLBkebeWhM/T7gCcyK4S4BCUjhjA5GAURMzGsGUHJnn4d1KK4WEXqWhk7ThBCKppXBL03zMrglqgtUs5jDXJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4fHTVWl4dJ9p7O0xHJAFFulkEaP2kpZKe0/PzusFbs=;
 b=o3GoDfA1hMezEIPxD6fA2XFsERwS3Q9kd58DBSotg45CD51iZzYKzsOegyjwh6qa0ffQoso1CDKWSpS+74DomqZDrmErEuQ7WXeWLMO8lycB1FNAJkWaPrBY50Cdk0HftdJMZs0rjrvSRBM7ZK1YvbTWq+uIzYgInxk0NvXakB6xLVS7g8Fo5nCt0YdNYYo+HYXvrqJBYNxCVuGKN+pzWHVw+ZgmLOLq03yy78OLtMfs0BhvfP/GxPMypbWGk7Maawk3hZnSyJ54PyDAMteCYjN8OM5jBUd9goKP7EddJPBah/qb4L12wWcJJtJUnDencVBuMxBoSNw/4E4KRsGzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4fHTVWl4dJ9p7O0xHJAFFulkEaP2kpZKe0/PzusFbs=;
 b=ADm3X3H1ssLf80hQRZBwzWA1rdCXx6iTg1WSN6n0fdfQAUt89WBgcWw5ZA1uFLgqE2jzQQaN4nP/Wx4RZOE5EMa1CiPFmtqANq7n3MUps5po8C3VFOArIIxYTFmBQIVNT6lBOeUydttH98k2+pCaqKSq3LbqaUO356ryQHJILdGJ8Rwsta27kpTsYGGrbORy4cHBXQZW36qJ/rbYz6CyL7RIdki6z6qND7wKh5wmVaT38WEnn1n6A4chHStWaZMRJAJAEWVja+fo/pmX2Yvhfg/Wptprd21uqb9IqmSVcFNMfhGBNpeXnLdYle5rfNbiSgbWpG1qXxHPz8wjvkdIog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 06:56:58 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 06:56:57 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Eliot Courtney <ecourtney@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
References: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
Subject: Re: [PATCH 0/7] gpu: nova-core: merge `load` and `boot` for falcons
Message-Id: <179576241741.1176041.10572955959825926061.b4-ty@b4>
Date: Fri, 27 Nov 2026 15:53:37 +0900
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0046.jpnprd01.prod.outlook.com
 (2603:1096:405:372::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: b220a1b7-fa6f-418b-c9e9-08df4c53a0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|23010399003|11063799006|261009223027099003|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: Tf05TLYs5B/y1OkT/Up7s6EVpnAgXoUFwIT0ItkduJEIZzm8eRRJEpOMCIq3ZgPsHFeTmCg9tuWCJE5OlTXTKPTcSWvEsAzSoNw9Exa4wo5+7KsmGNpUnDcExd3hpjcT9ljP669C6YkY1IJ3SbjmAfcLN8jbEbsoLQWAteDHIcUsmnMt/zS/ZeE+jaP1CAOSwfCS1wtPFMhjIhGy3+PDMvEKUtXpTKAy18MNdluHOo6MdXvFoKbJZQbqV+ZhdRoS19YuCl8g3h5cWW0eQz0Loq8oYABxr0AsvEEbOnCs22yMSE1piDUlYWewUm2kZGUQaYN0/s9jVZu1Rwllrlm+jH/WEoPHZRn20WM/awfkI0+mf353oUKaqIi+nEypF1qq7uurWGl07nPCOiCGeTwyXKlVsH1kHAUjKzMtChgsAAcWGnf9WUQtWjT8L1Dbho05ZGkaPFKKR+qCUMo/ubZmnvriUlYV7eOnZKUJAZVzgm5paJN9Io8DQXINDwCbQSyfyTy9cKR4nuXOXIaA8z9Ws7gSzNQWXy3xuJQxGrmOYVB+BwkttE2Ge5RSBls5GUHu+e9xVDbiHWRs1ygAur7h2/0kGzK9cTtMDtbxoE9FFGp23V2nruTMFEM3YRoOFTWifCP3WbIWiBdNXbV78PjiDsUcTlP7OvpvcpHgtIJS8ig=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(23010399003)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck5VSHFJajh0cCtMQVU3QUFLd3dnUmw0dkVwNkNYM0g4c2xQbHNGZk91ZlJo?=
 =?utf-8?B?ODZ3M2NoRmhoU0kwdUhUUStJVnZCc0EyTXRrMGU4VVdFWFY2Wm82cFZlVFJN?=
 =?utf-8?B?VjRxK01uYmhHUCtqczRVMTJJZHBjSWpNMHNZR2hoNnM1K3RxczlZK0JWSHdX?=
 =?utf-8?B?VlBrUVZlVUNxdndDd3hRamE3VHR0QUR2dnpBdEhSaVFsYzlQYW5lU3NkKyti?=
 =?utf-8?B?QUc0elNuNDhUK3dhOU1FOHQ2MGV4T1BjeFFqNE1ScmNjdk5kSk5QR1ZESVZq?=
 =?utf-8?B?eEl1QjVOWm9tam5aN3RkUGlIU1IxZE53RnlkeGFhcCtMS05hTzB2MGlET3FH?=
 =?utf-8?B?dUduQUlFRXJZemd0NmN4WHUzN0JqUEJpREh2VUtvOUhuTjR5cFpQN09VeXNr?=
 =?utf-8?B?S0R0UUNIM1JINmxTazBOak9ONks3eVdHOWF6Z3ozS1pSOGNGNFVUZmcvMVUx?=
 =?utf-8?B?aFFHNzZYdkJGYXlNbE5qdC8yZ0R5aTQxclVpNTlYSTdLY3V6VUFteEhueHA3?=
 =?utf-8?B?MjI1MEhxNjRLeGRWbllNcnhuKzlWWlIvc1dadVArVEViL0lEd3doaWJGeVpH?=
 =?utf-8?B?TkRyekNDTVJkbkJDczB0dWQzSS9zUWdPVDJIa3Y2K1dNT2lpRTRON2YzeFZ1?=
 =?utf-8?B?MkFzNk0xbDlHRkwyMnpZbTdDZmgxRkNNbXM1eHo3c3duWUhBaWR1TlhLMDJq?=
 =?utf-8?B?OTRvRVcxS2k0Vy9EZTd6eFREN041QmRBR0toU1ZxUkwwVDE0cEY1empRM0JH?=
 =?utf-8?B?dGtKMEplNHd0N1VuKzd0VlAzcG5WN1Z0OG0vcmNyY1dESEtGU2VDTG5KREls?=
 =?utf-8?B?SmRYRkxDSTV0cXpxTWowbitZcER4bG1ocFZuZXVEdGFjaTgyT2s3T0NrOGts?=
 =?utf-8?B?R0RUN2VpVDkzeXFYSm9vejNkK0p2RDJVVitGMkdYeFNsVkpRcXdidFlrY0c0?=
 =?utf-8?B?UVhvQzJINmV3Ly9XTitNdDh4Wk92Ris0L0M4b3NTS2dLKzUzRFRGQndGdTFR?=
 =?utf-8?B?WFkwcXdKQkgzRDdyUlhUTkhlWnJMemIzRTBYRHJ1MGNCVWYvRUE0dG9BZGVy?=
 =?utf-8?B?a2phN052ekhERTZjekdsUVdjU294ZlZld3YyZUc3SmZOWVdndHUwV2hqY0tj?=
 =?utf-8?B?TWkzQmJLS3lVMGYwZE1MRFFuZ0k3RWZ0aTBPaTE5L2l2cDV6SFNaMGFJTXVo?=
 =?utf-8?B?anlFdjdqWkdnYnlJRWRaamwrN0pWbTBoNW5UMDE3U3JxanVweUpwOWEwVTlj?=
 =?utf-8?B?NkRmZWZBYUMvMXFZN3RsczRaREc3NnF2N2dIemxLQTRueXg4dzlYQjV5aUJZ?=
 =?utf-8?B?VE1MaXg3c3ROc09xTVFTL2hQeVMxQVNCTmViR1B6RmxRbTZlbjNRUnVvY3Ry?=
 =?utf-8?B?SkpmbVFyRlFmNkdoM0RVMFdlQW9OK2FMSC96d3RtMWRUQmZCMGt6YkN3clJ6?=
 =?utf-8?B?clhjVFRhMXZUbGtUNnAzZGtJK1hudXRFUExHdE5JS1pXd0F6S014Q1FWN0Va?=
 =?utf-8?B?c3pOa3F4RXoxSll2QURjOHZxWUVhMDNwVWxBS0E5cDUvZzI5R2dVZ0c4aEJY?=
 =?utf-8?B?TzVvWExkYUVtODhTdEU0S0xqVi9wV3pTZGZJRUt4SlhTb25QdFpkYXk4Z2Vu?=
 =?utf-8?B?VlI3TFNwSWl3SjRuei9sckhKa2xjZ0xMbDViSEFZYjB3OWlCd1N4SkRxampQ?=
 =?utf-8?B?MktEb2J5dWhYVEVBS2ROT0hHME1QM1B5ODVEdnNXU1U0Vm1yVE51Z0xpVnQx?=
 =?utf-8?B?SVJTai9sWVpDQTRzRU5nKzA0RjlwWU9lNFMrbWQ5ZGszNnJhVGJ3cTNCbTJR?=
 =?utf-8?B?V3h3eElSM3dRa0FNYmRiY3k2SnVPRlFIZ3Y1aXkrMWxmMmNzRW1NM3VBUzZF?=
 =?utf-8?B?T1ZIdEQ2bGU0Y2RrMkJSVEZReGNHUkMxVENXT2RrQlkzd1ZKODRraUwySzA2?=
 =?utf-8?B?Y1h1STJJWFlSQVRBcVJ1c0h6YVRoWXdTMmEvR3gxNWlEYVdrcmFFeW9CVjRI?=
 =?utf-8?B?SFlTRmFQamlaWGVEV05peVN1Y0txVkhLRzVXVkd3YkY5Q2xRemhvMWpXNFA1?=
 =?utf-8?B?dFlIYkFiK3R0N05LNnlCSGVTVS9SZkJramtSc1BNTVhRRFkxNGVEampWcUx0?=
 =?utf-8?B?eEQ0SXRkdXd6YVJMTkwyUUlzTGY1NkltQ0hNRjA2VFJtYVlGWHJPUjFwWlVQ?=
 =?utf-8?B?RncrY001L0lyOXpnYno1ZUhoWXBYaUlET0hYV1VHbTc1akFXREZjWlVvdERq?=
 =?utf-8?B?QU0zWUZwNkg2a2JmMjZVaExWWmg3MC9zUFB4L09PaUN5QTIyU2JLNDNCZWk1?=
 =?utf-8?B?bHZvamViTlVET1hBWUtjU0dIOUFDNENjTE5wS0ZkV1EyU1gzbnJZM0diUnJs?=
 =?utf-8?Q?wQpjpjvBw0x2+3PrxFnnMGQA7IA/QrPwwcKtq23yeWloW?=
X-MS-Exchange-AntiSpam-MessageData-1: hgv9CblloeEx2Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b220a1b7-fa6f-418b-c9e9-08df4c53a0f2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 06:56:57.9040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +G3+2DsSJFpRnmdupiZApW928b4NOuCidhAMmkQK84hBTpQ92AKs8gLEt/AaXDuQPlckWzZD1JOlcrDANLImLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170
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

On Thu, 26 Nov 2026 17:20:09 +0900, Eliot Courtney wrote:
> Currently, loading the firmware and booting it is split into two
> separate steps. Load is always called in combination with boot. Rewrite
> the process to basically look like:
> 
> falcon.boot(<the firmware you want>, ...)
> 
> Additionally, add a segment source for firmware already in the
> framebuffer (this is for HS binaries).
> 
> [...]

1 and 2 applied to drm-rust-next, thanks!

[1/7] gpu: nova-core: falcon: make pfalcon private
      commit: e91da12099a5536c6a1852c6fb7800ef6460103d
[2/7] gpu: nova-core: gsp: remove unnecessary start of `gsp_falcon`
      commit: abfb640b2374e26de8ff81d488c39d8254db538e
