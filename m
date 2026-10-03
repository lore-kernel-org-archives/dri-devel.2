Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F318DCA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BE0A10EAF9;
	Sun,  4 Oct 2026 17:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=michaelburch.net header.i=@michaelburch.net header.b="g1p6zEjO";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11020104.outbound.protection.outlook.com
 [52.101.193.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E26E10E0AD;
 Sat,  3 Oct 2026 19:38:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=II7T8JhafsyXxANhamSzhoxM529jg026AOfN1QYb7NhUN5IvvPtDpMQR8oj7qk5yW9rdVUiuvTFOJ4FBV46AhVgR/zl5ID9zkCu6Qf5FZGvKzc3bkaez3PgKYDAT2lq2aQKkuco6witkAA/rhA5K8lpluYUkMvkGuZvpIRzeVRj+hNwZJk+Txj23qixxhMA7t2A1I5Z6InO/THmQ5LOeaVwwvju+0dpwHsj3nKcwaq/53uXerpBwFD2PN3UurOivwZYhypA0Uj64556f7qSj51SnwU0kSqjiUlG4ksL7OaqQWPFuhUVHAkETZIJGvT2Y61TWZPCSkGkDY4+IXMPMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhMjclB6ysfrDphpoLp2LhNIvv0alrYqIjbudv02/lY=;
 b=oLl6vi2sNo1lNWS6FsvsvQZbmt8ANq/YCxles4HoA6TxUqBGmAyhFcUKWHEh4SrfJ6cK3y0OuDQ2MwOQsMREyBEuTbVA4sMeQ8bybX8bvFyw+ZwyWwP15jjgjx9UVdNOpJlEjrNOtGS6Xv/YhKPY876yUAbRIZdEUK2qAfDLaf2bUmCZ/2mYJIQ87oFuADFkP+PKp9LslVa/5DbLYWhrku91GNqFHFkdkdamawkvXhAgEDdtZ2xC4tC96RZKXLJOYGcEhjsKA0/0Kjhph/aB+q2CBMqyDHd4Xe2OZa9wqDI9XWgEG60eLgAqDzXOpQicd8ys3vcVGrpnx4f60kdpHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trailworks.io; dmarc=pass action=none
 header.from=michaelburch.net; dkim=pass header.d=michaelburch.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelburch.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhMjclB6ysfrDphpoLp2LhNIvv0alrYqIjbudv02/lY=;
 b=g1p6zEjO7MKJy8YNrqNg1//a91B5tCoWEWPYE/nrWI0eFWw/YV2olJPvoqpEtPutQQW8BORSim4kKXTNMKyT9Wb5c211VXjO3YJNQ/zBEH2uJNd6KEgM66sxduNODePAl/dt5fX+K/JjhtJRXXrOLrIs2W+G88r459ze7RoFTQaUv74eNRScZKsWucnmRpQPB2jcfYdrD+za7uxMFbeBUq2BPAYWnHr5tl/gkg9e4ozLqS0QD3u58mEWldebhSlgmuBHNiW/Hu8w+xKI1P254m8mpK2+9oqyttsrbldIzwun/OwKU0kqNlNXGzH3wg5HCRuhNHupOR3uo4f6hgDB9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=michaelburch.net;
Received: from PH7PR01MB8123.prod.exchangelabs.com (2603:10b6:510:2a4::19) by
 IA4PR01MB133332.prod.exchangelabs.com (2603:10b6:207:101::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.20; Sat, 3 Oct 2026 19:38:08 +0000
Received: from PH7PR01MB8123.prod.exchangelabs.com
 ([fe80::da98:a31d:73b6:7930]) by PH7PR01MB8123.prod.exchangelabs.com
 ([fe80::da98:a31d:73b6:7930%5]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 19:38:08 +0000
From: Michael Burch <me@michaelburch.net>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Shivam Rawat <shivrawa@qti.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/msm/a6xx: Fix stale rpmh votes after suspend
Date: Sat,  3 Oct 2026 14:37:57 -0500
Message-ID: <20261003193759.14228-1-me@michaelburch.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260605-assorted-fixes-june-v1-1-2caa04f7287c@oss.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-1-2caa04f7287c@oss.qualcomm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:806:20::13) To PH7PR01MB8123.prod.exchangelabs.com
 (2603:10b6:510:2a4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8123:EE_|IA4PR01MB133332:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b1e54a-53af-455d-dd6a-08df2185d9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zej9nn/Vl99Muc2bVmw5a/q2APvqOa2NY59fA1ewmbMMWRLppOJAXcpE9q2jCpBIDSG7dhQesBys/P8fuIg3/Ej/3GNNTtg8db4rtkK5Lzg4xn6fdBwXLFYz8kJHlkuPSzDPCoIozc35b2LAJGUtL2NQ5XiMrmn/tamz1Xm3bGZKRTnfcalJz12HLhlrpUM/6Hac7g4gebeikxZbXEBxO8Wyzt11mXRtESyLSB3RJa/t+BnkToxo8ycQsL99zl79R74f1U5zJnj5wX3CXEXSDBX2tryqsWd9J7i8mj7+dsVB2oX12JuFn6QzH4MWKNl5g+WTlvoFG2kDvO2NSXEzQ5cDWOREz/BFXJo7w0mA+wu9HNvYa6LnYkgHBRs0eL3XXCZ49lVuqCTZGEymA51JfmlNP1PnirgYip3TY307mIFPeOuHgEe+2w6Kur6n5QSwUVJ6kEPI8UhSAcHUMrBE1+uE7PBB/0lnZyP5oq/K+0zaPhlPEn0sVm/cfIKjwflqNnApyPZUM1dhKXmv3gcPXTrIWH3kFpxQAzLZqRPbID1HEUfCeWMXb9XaomzQnH26970rly+Nv71f5Z63CUHgECVyrymeZJUodZKuwf2Z+toB40qBq23KeOMlqXT0f7t24Stv9cymhmQ8qk2B6SlxLi/qYlER4SpSgHBSa6pKWzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR01MB8123.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j13VvquPGIcb+liZnB9mu64nYRAxtxr+SX4/dvUX4O+UMIEophF0h5K2YE5K?=
 =?us-ascii?Q?u2A5XCJVk7M2xpJsAoKLSPJBg1qiac/mozqoK//0pggEySh1qGzhFHVl57Z1?=
 =?us-ascii?Q?H+6pcK4JScyvSnPnwMkDPo2uyFayHT2QNk4hyldQkz/Xd0z6jPl0ENItrYtH?=
 =?us-ascii?Q?nW0HyKYlEJmiRZOCiUMj30UpYEeC9Zv/GfYoHee0Xmce9w62WOXfJ2RKhJBq?=
 =?us-ascii?Q?i/7oPHhbSI8eh1svHhAEn1tAbjPoMeyE8qt3rQNP+3TXqpStQAuhAtVbANQX?=
 =?us-ascii?Q?jPSFwevPsdsLt3xobHmxpvJc8MannDxaED2CaWNSm9e+4QveRD+8nOl7Yeto?=
 =?us-ascii?Q?2CUAG17RjBtXvY1cvTrispJ061FbVIFVTUEGFnxW9jQnJJlbXKZXFFSFiceJ?=
 =?us-ascii?Q?OK4ZKorHnZlMQCToolIXfyHJlRG2a1fGBUoOgn8DFnYfkGR3P+dYb830zwFM?=
 =?us-ascii?Q?W0x8PQwibLk3DoCNhySWOnBiK8ycgs4FVF13BfdEQwFM5B80nxIJFR/1ZrQ1?=
 =?us-ascii?Q?cHqToCxDP2kotathaYQz0NiXAbuZnTt/rdaMJJM3+xGEINhh7nVyj/cNK2rH?=
 =?us-ascii?Q?5d07qo1tSoB6AT97Mda/AbhJ/TqUI1JTWfTQ9JtRF0LSnPQFbZ5G8u+eQDYb?=
 =?us-ascii?Q?CZBY5d9WJ4pMllCfONHvdpH6ANBJZHBSRdNWPH9kaQtGCp3dGx0MaALzeicH?=
 =?us-ascii?Q?3H8BvJwfL6JMW+r5RyLQSB4pyPcxb6iy7301rEPRUTrQPVcWkMb4jqRoR9WJ?=
 =?us-ascii?Q?efFnfdxO3cnzWwc/ddJ3MgEWaucr/FaoK1IeRt0OUP9xHbVUm3AWhZ0OIWcg?=
 =?us-ascii?Q?eIm2kg6U4qQsn5t00MjbeprDFor9ya0FF2ZrkFBGoJpeiWHFvPAA8crXvDQi?=
 =?us-ascii?Q?WQ9fjbIyOPh+Tjf1sEQJDs3tqjD83RmjHHw2eKIdxDUgrIJVSypZqstOp1ta?=
 =?us-ascii?Q?4fc8qCLKmO2JEjiEpkhsp8sxDvS6Dl1oYiGzpkh2oXHKCdB2/BSj9hk5crJP?=
 =?us-ascii?Q?pQ/fEmxophA+E+bCVjBMr0mb6sdvyG2Jw5mC3AKh0AxLLzrNEaSAs2dCqhL+?=
 =?us-ascii?Q?yf3FOKpFqqidBbI7Bw0rJJqaI6vqmbm/MYtxB3BqsWoRKs+tvfSGwyHJ1Vg1?=
 =?us-ascii?Q?agnQgYuqMqKPaETDWAdajGdWVjAj1AxI7m54qc5lgZHc0QH8ovU+hxfPqFv0?=
 =?us-ascii?Q?0jXHIy8q92K2Wm8P1MyUCcT5Nmv52B4zM5e8IT3hrI9hWSpdW7PtrxZg8o31?=
 =?us-ascii?Q?31jNH8HzZx/E3/GJoLsOz7F4Oxm1xymthAJCToAiurarzvIbpxSs75iKWnmZ?=
 =?us-ascii?Q?fhMhw5e7tKNYNpLxJmLAVXmxpazMmHCzG+jSkK1TrrbNG4Ym6OJ6pare0z56?=
 =?us-ascii?Q?YwDYSEnwLvyYOWpiOo2q6V8e6asmxpwmgkZIHUfEeYGilEgMg+OBkmSyo9Ff?=
 =?us-ascii?Q?Iu8FW1/6fQGoIJqLEkhPIqUhUui6RvDeI1FMEYwA1XGtIxeOSQtYL/VSfVgY?=
 =?us-ascii?Q?POJiGDcQR8itGi9oVgsq0xnLfcteMI/UFfTBcgt+Ot0o6toc+bOZAgD+GS/1?=
 =?us-ascii?Q?GqIZ0Jbp+XeSS5nwn5V3kQtqbDrt6g022S6mlEI3pygPj7Qp5VO92hicdnUq?=
 =?us-ascii?Q?Uv2PUYopImfdMJZ35urZCejjHowX5eYT5Rpr4v8cPyc9XCBl6CZn552uQ7Bx?=
 =?us-ascii?Q?sQbut821SM7VJZbC9yPVdJ16DD/uGbD20GyJjfM4J+blPNXGOLLbqM8A1lmw?=
 =?us-ascii?Q?5U23R/3ZSw=3D=3D?=
X-OriginatorOrg: michaelburch.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b1e54a-53af-455d-dd6a-08df2185d9c6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8123.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 19:38:07.9730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8256b244-08e6-4df2-b146-877069d9ce10
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2qV5HOcqSGlRijJa0q8frk6JAuTg/+gl6vWEd9KarydkR/zvZKkTqtSfFce/OiqWDEPjOQcu+HkeLOMthOF8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR01MB133332
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

On X1E80100 (Dell XPS 13 9345) this patch seems to cause poweroff to
reboot instead. Reverting just the FW_START hunk avoids it, and so does
keeping the GPU awake until shutdown, so I suspect the PDC being asleep
at system off.

I've posted a fix, "drm/msm/adreno: Leave the GPU RSC awake for system
poweroff":
https://lore.kernel.org/all/20261003193518.13811-1-me@michaelburch.net/

On this machine it resolves the reboot: poweroff and reboot work on AC
and battery, and deep suspend still drops the GPU votes. There may be a
better approach, e.g. waking only the RSC; happy to test.

Thanks,
Michael
